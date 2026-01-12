FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    sudo curl wget git nano vim net-tools iputils-ping \
    openssh-server ca-certificates unzip htop tmux screen && \
    apt clean

RUN mkdir /var/run/sshd
CMD ["/bin/bash"]
