#https://github.com/tianon/docker-brew-ubuntu-core.git
FROM base:dev.lang

# VULN_SCAN_HASH=
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8
USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    mesa-common-dev        \                               
    libglu1-mesa-dev       \
    libxi-dev              \
    libxrandr-dev          \
    x11-xserver-utils


#RUN PATH="/opt/gtk/bin:$PATH"
USER dev

#to base:dev.lang.nlp
