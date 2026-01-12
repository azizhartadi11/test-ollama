#!/bin/bash
apt update && apt upgrade -y
useradd -m hacker || true
echo "hacker:hacker" | chpasswd
usermod -aG sudo hacker
service ssh start
