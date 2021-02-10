#https://github.com/tianon/docker-brew-ubuntu-core.git

# VULN_SCAN_HASH=
#ENV DEBIAN_FRONTEND=noninteractive \
# LANG=en_US.UTF-8

FROM base:dev.lang

# VULN_SCAN_HASH=
USER root

RUN  chown -R dev.dev /home/dev/
RUN  chown -R dev.dev /home/dev/.vscode-server
RUN apt-get update && \
     apt install -y --force-yes --no-install-recommends ttf-wqy-zenhei &&\
    apt-get remove -y locales && \
    apt-get install -y locales && \
    apt-get install -y apt-utils && \
    apt-get install -y language-pack-zh-hans && \
    apt install -y --no-install-recommends ttf-wqy-zenhei  &&\
    locale-gen zh_CN.UTF-8  


ENV LANG=zh_CN.UTF-8
ENV LANGUAGE=zh_CN:en
run apt-get install -y --no-install-recommends \
    wine  &&\
    dpkg --add-architecture i386 && apt-get update &&\
    apt-get install -o APT::Immediate-Configure=false -f -y wine32 && \
    apt-get install  -y --no-install-recommends \
    wine32 \
    wine-binfmt \
    libatspi2.0-dev \
    libgtk-3-dev \
    libatk1.0-dev \
    libxtst-dev \
    libnss3-dev
#RUN PATH="/opt/gtk/bin:$PATH"
USER dev

#RUN PATH="/opt/gtk/bin:$PATH"
#to base:dev.lang.wine.test
