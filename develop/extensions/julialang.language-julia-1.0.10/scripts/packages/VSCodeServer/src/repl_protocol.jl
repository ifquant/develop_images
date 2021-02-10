JSONRPC.@dict_readable struct ReplRunCodeRequestParams <: JSONRPC.Outbound
    filename::String
    line::Int
    column::Int
    code::String
    mod::String
    showCodeInREPL::Bool
    showResultInREPL::Bool
    softscope::Bool
end

struct Frame
    path::String
    line::Int
end
Frame(st::Base.StackFrame) = Frame(fullpath(string(st.file)), st.line)

JSONRPC.@dict_readable struct ReplRunCodeRequestReturn <: JSONRPC.Outbound
    inline::String
    all::String
    stackframe::Union{Nothing,Vector{Frame}}
end
ReplRunCodeRequestReturn(inline, all) = ReplRunCodeRequestReturn(inline, all, nothing)

JSONRPC.@dict_readable mutable struct ReplWorkspaceItem <: JSONRPC.Outbound
    head::String
    id::Int
    haschildren::Bool
    lazy::Bool
    icon::String
    value::String
    canshow::Bool
    type::String
end

const repl_runcode_request_type = JSONRPC.RequestType("repl/runcode", ReplRunCodeRequestParams, ReplRunCodeRequestReturn)
const repl_interrupt_notification_type = JSONRPC.NotificationType("repl/interrupt", Nothing)
const repl_getvariables_request_type = JSONRPC.RequestType("repl/getvariables", Nothing, Vector{ReplWorkspaceItem})
const repl_getlazy_request_type = JSONRPC.RequestType("repl/getlazy", Int, Vector{ReplWorkspaceItem})
const repl_showingrid_notification_type = JSONRPC.NotificationType("repl/showingrid", String)
const repl_loadedModules_request_type = JSONRPC.RequestType("repl/loadedModules", Nothing, Vector{String})
const repl_isModuleLoaded_request_type = JSONRPC.RequestType("repl/isModuleLoaded", String, Bool)
const repl_startdebugger_notification_type = JSONRPC.NotificationType("repl/startdebugger", String)
const repl_showprofileresult_notification_type = JSONRPC.NotificationType("repl/showprofileresult", String)
const repl_showprofileresult_file_notification_type = JSONRPC.NotificationType("repl/showprofileresult_file", String)
const repl_toggle_plot_pane_notification_type = JSONRPC.NotificationType("repl/togglePlotPane", Bool)
const cd_notification_type = JSONRPC.NotificationType("repl/cd", String)
const activate_project_notification_type = JSONRPC.NotificationType("repl/activateProject", String)
const activate_project_from_dir_request = JSONRPC.RequestType("repl/activateProjectFromDir", String, Union{Nothing,String})
