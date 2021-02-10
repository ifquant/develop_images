#https://github.com/tianon/docker-brew-ubuntu-core.git

# VULN_SCAN_HASH=
#ENV DEBIAN_FRONTEND=noninteractive \
# LANG=en_US.UTF-8

FROM base:dev.lang.wine

# VULN_SCAN_HASH=
USER root

copy wechat_web_devtools /home/dev/wechat_web_devtools 

RUN  chown -R dev.dev /home/dev/wechat_web_devtools 


ENV LANG=zh_CN.UTF-8
ENV LANGUAGE=zh_CN:en
#RUN PATH="/opt/gtk/bin:$PATH"
USER dev

RUN  mkdir -p /home/dev/.config/wechat_web_devtools/WeappVendor/
RUN  cd /home/dev/wechat_web_devtools/ &&\
     ./bin/wxdt install



USER dev
#RUN PATH="/opt/gtk/bin:$PATH"
#to base:dev.lang.wine.test
#
