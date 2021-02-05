#https://github.com/tianon/docker-brew-ubuntu-core.git
FROM ubuntu:20.04

# VULN_SCAN_HASH=
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      git \
      vim \
      less \
      python3 \
      python3-dev \
      python3-pip \
      python3-setuptools \
      python3-wheel \
      libssl-dev \
      libcurl4-openssl-dev \
      build-essential \
      sqlite3 \
      curl \
      dnsutils \
      sudo
#
#      && \
#    rm -rf /var/lib/apt/lists/*

RUN apt-get  install -y --no-install-recommends\
     build-essential
     

ARG DEV_USER=dev
ARG DEV_UID=1000
ARG HOME=/home/dev

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${DEV_UID} \
    --home ${HOME} \
    --force-badname \
    ${DEV_USER}


RUN echo "dev ALL=(ALL)       NOPASSWD:ALL\n" >> /etc/sudoers
RUN pip3 install --upgrade --no-cache-dir \
        setuptools \
        pip
WORKDIR /home/dev/

# So we can actually write a db file here
RUN chown ${DEV_USER}:${DEV_USER} /home/${DEV_USER}

USER ${DEV_USER}
CMD ["/bin/bash"]
