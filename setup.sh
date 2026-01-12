#!/bin/bash
set -e

echo "[+] Updating system"
apt update && apt upgrade -y

echo "[+] Creating user hacker"
useradd -m -s /bin/bash hacker
echo "hacker:hacker" | chpasswd
usermod -aG sudo hacker

echo "[+] Configuring SSH"
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
service ssh start

echo "[+] Ubuntu Codespace ready!"
echo "[+] User: hacker | Pass: hacker"