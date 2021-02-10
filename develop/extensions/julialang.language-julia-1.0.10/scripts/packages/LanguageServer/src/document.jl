mutable struct Document
    _uri::String
    _path::String
    _content::String
    _line_offsets::Union{Nothing,Vector{Int}}
    _line_offsets2::Union{Nothing,Vector{Int}}
    _open_in_editor::Bool
    _workspace_file::Bool
    cst::EXPR
    diagnostics::Vector{Diagnostic}
    _version::Int
    server
    root::Document
    function Document(uri::AbstractString, text::AbstractString, workspace_file::Bool, server=nothing)
        path = something(uri2filepath(uri), "")
        cst = CSTParser.parse(text, true)
        doc = new(uri, path, text, nothing, nothing, false, workspace_file, cst, [], 0, server)
        get_line_offsets(doc)
        get_line_offsets2!(doc)
        cst.val = path
        set_doc(doc.cst, doc)
        setroot(doc, doc)
        return doc
    end
end
Base.display(doc::Document) = println("Doc: $(basename(doc._uri)) ")

function set_doc(x::EXPR, doc)
    if !StaticLint.hasmeta(x)
        x.meta = StaticLint.Meta()
    end
    x.meta.error = doc
end


function get_text(doc::Document)
    return doc._content
end

function set_text!(doc::Document, text)
    doc._content = text
    doc._line_offsets = nothing
    doc._line_offsets2 = nothing
end

function set_open_in_editor(doc::Document, value::Bool)
    doc._open_in_editor = value
end

function get_open_in_editor(doc::Document)
    return doc._open_in_editor
end

function is_workspace_file(doc::Document)
    return doc._workspace_file
end

function set_is_workspace_file(doc::Document, value::Bool)
    doc._workspace_file = value
end


"""
    get_offset(doc, line, char)

Returns the byte offset position corresponding to a line/character position.
This takes 0 based line/char inputs. Corresponding functions are available for
Position and Range arguments, the latter returning a UnitRange{Int}.
"""
function get_offset(doc::Document, line::Integer, character::Integer)
    c = ' '
    line_offsets = get_line_offsets(doc)
    io = IOBuffer(get_text(doc))
    try
        seek(io, line_offsets[line + 1])
        while character > 0
            c = read(io, Char)
            character -= 1
            if UInt32(c) >= 0x010000
                character -= 1
            end
        end
        if UInt32(c) < 0x0080
            return position(io)
        elseif UInt32(c) < 0x0800
            return position(io) - 1
        elseif UInt32(c) < 0x010000
            return position(io) - 2
        else
            return position(io) - 3
        end
    catch err
        throw(LSOffsetError("get_offset crashed. More diagnostics:\nline=$line\ncharacter=$character\nposition(io)=$(position(io))\nline_offsets='$line_offsets'\ntext='$(obscure_text(get_text(doc)))'\n\noriginal_error=$(sprint(Base.display_error, err, catch_backtrace()))"))
    end
end
get_offset(doc, p::Position) = get_offset(doc, p.line, p.character)
get_offset(doc, r::Range) = get_offset(doc, r.start):get_offset(doc, r.stop)

function get_offset2(doc::Document, line::Integer, character::Integer)
    line_offsets = get_line_offsets2!(doc)
    text = get_text(doc)

    if line >= length(line_offsets)
        throw(LSOffsetError("get_offset2 crashed. More diagnostics:\nline=$line\nline_offsets='$line_offsets'"))
        return nextind(text, lastindex(text))
    elseif line < 0
        throw(LSOffsetError("get_offset2 crashed. More diagnostics:\nline=$line\nline_offsets='$line_offsets'"))
    end

    line_offset = line_offsets[line + 1]

    next_line_offset = line + 1 < length(line_offsets) ? line_offsets[line + 2] : nextind(text, lastindex(text))

    pos = line_offset

    while character > 0
        if UInt32(text[pos]) >= 0x010000
            character -= 2
        else
            character -= 1
        end
        pos = nextind(text, pos)
    end

    ret = min(pos, next_line_offset)

    return pos
end

# Note: to be removed
function obscure_text(s)
    i = 1
    io = IOBuffer()
    while i <= sizeof(s) # AUDIT: OK, i is generated by nextind
        di = nextind(s, i) - i
        if di == 1
            if s[i] in ('\n', '\r')
                write(io, s[i])
            else
                write(io, "a")
            end
        elseif di == 2
            write(io, "α")
        elseif di == 3
            write(io, "—")
        else
            write(io, s[i])
        end
        i += di
    end
    s1 = String(take!(io))
end

"""
    get_line_offsets(doc::Document)

Updates the doc._line_offsets field, an n length Array each entry of which
gives the byte offset position of the start of each line. This always starts
with 0 for the first line (even if empty).
"""
function get_line_offsets(doc::Document, force=false)
    if force || doc._line_offsets === nothing
        doc._line_offsets = Int[0]
        text = get_text(doc)
        ind = firstindex(text)
        while ind <= lastindex(text)
            c = text[ind]
            nl = c == '\n' || c == '\r'
            if c == '\r' && ind + 1 <= lastindex(text) && text[ind + 1] == '\n'
                ind += 1
            end
            nl && push!(doc._line_offsets, ind)
            ind = nextind(text, ind)
        end
    end
    return doc._line_offsets
end

function get_line_offsets2!(doc::Document, force=false)
    if force || doc._line_offsets2 === nothing
        doc._line_offsets2 = Int[1]
        text = get_text(doc)
        ind = firstindex(text)
        while ind <= lastindex(text)
            c = text[ind]
            if c == '\n' || c == '\r'
                if c == '\r' && ind + 1 <= lastindex(text) && text[ind + 1] == '\n'
                    ind += 1
                end
                push!(doc._line_offsets2, ind + 1)
            end

            ind = nextind(text, ind)
        end
    end

    return doc._line_offsets2
end

function get_line_of(line_offsets::Vector{Int}, offset::Integer)
    nlines = length(line_offsets)
    if offset > last(line_offsets)
        line = nlines
    else
        line = 1
        while line < nlines
            if line_offsets[line] <= offset < line_offsets[line + 1]
                break
            end
            line += 1
        end
    end
    return line, line_offsets[line]
end

"""
    get_position_at(doc, offset)

Returns the 0-based line and character position within a document of a given
byte offset.
"""
function get_position_at(doc::Document, offset::Integer)
    offset > sizeof(get_text(doc)) && throw(LSPositionToOffsetException("offset[$offset] > sizeof(content)[$(sizeof(get_text(doc)))]")) # OK, offset comes from EXPR spans
    line_offsets = get_line_offsets(doc)
    line, ind = get_line_of(line_offsets, offset)
    io = IOBuffer(get_text(doc))
    seek(io, line_offsets[line])
    character = 0
    while offset > position(io)
        c = read(io, Char)
        character += 1
        if UInt32(c) >= 0x010000
            character += 1
        end
    end
    close(io)
    return line - 1, character
end

"""
    Range(Doc, rng)
Converts a byte offset range to a LSP Range.
"""
function Range(doc::Document, rng::UnitRange)
    start_l, start_c = get_position_at(doc, first(rng))
    end_l, end_c = get_position_at(doc, last(rng))
    rng = Range(start_l, start_c, end_l, end_c)
end