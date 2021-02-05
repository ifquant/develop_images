#https://github.com/tianon/docker-brew-ubuntu-core.git
FROM base:dev

# VULN_SCAN_HASH=
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8
USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gdb              \
    clang-11         \
    clangd-11        \
    python3-clang-11 \
    exuberant-ctags  \
    neovim           \
    wget             \
    julia            \
    r-base           \
    unrar            \
    nodejs           \
    net-tools        \
    subversion       \
    cmake            \
    yarn             \
    libboost-dev     

    pkg-config

#install go
RUN apt-get install wget -y
RUN wget https://golang.google.cn/dl/go1.15.7.linux-amd64.tar.gz -O /tmp/go1.15.7.linux-amd64.tar.gz
RUN tar -xzf /tmp/go1.15.7.linux-amd64.tar.gz
RUN mv go  /usr/local/
RUN PATH="/usr/local/go/bin/:$PATH"
USER dev
RUN PATH="/usr/local/go/bin/:$PATH"
USER root

#export PATH=$PATH:/usr/local/go/bin/

#install rust
COPY rs.sh  /tmp/rs.sh
#RUN curl  https://sh.rustup.rs  -o /tmp/rs.sh
#RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs  -o /tmp/rs.sh
RUN chmod +x /tmp/rs.sh
USER dev
RUN /tmp/rs.sh -y
RUN PATH="/home/dev/.cargo/bin/:$PATH"

#| sh 
#wget   sh -y
#$HOME/.cargo/bin
#export PATH=/home/dev/.cargo/bin/:$PATH


#RUN PATH="/opt/gtk/bin:$PATH"
USER dev

#to base:dev.lang
