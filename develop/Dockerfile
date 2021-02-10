#https://github.com/tianon/docker-brew-ubuntu-core.git
FROM base:dev.lang

# VULN_SCAN_HASH=
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8
USER root

RUN  chown -R dev.dev /home/dev/
RUN  chown -R dev.dev /home/dev/.vscode-server

#RUN PATH="/opt/gtk/bin:$PATH"
USER dev

#to base:dev.lang
