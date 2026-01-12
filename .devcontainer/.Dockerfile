FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y && \
    apt install -y \
    sudo \
    curl \
    wget \
    git \
    nano \
    vim \
    net-tools \
    iputils-ping \
    openssh-server \
    ca-certificates \
    unzip \
    htop \
    screen \
    tmux && \
    apt clean

RUN mkdir /var/run/sshd

EXPOSE 22
CMD ["/bin/bash"]
