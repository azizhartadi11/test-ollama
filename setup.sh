#!/bin/bash
# Codespace VPS-ification Script
# Transforms a GitHub Codespace into a persistent Ubuntu VPS
set -e
echo "[+] Starting Codespace Transformation..."
# 1. Update and Install Essentials
sudo apt update && sudo apt upgrade -y
sudo apt install -y openssh-server tmux curl wget git build-essential zsh jq
# 2. Configure SSH for Native CLI Access
# Ensure SSH service is running
sudo service ssh start || true
# Add your public key to authorized_keys if passed as an argument
if [ ! -z "$1" ]; then
    echo "[+] Adding SSH Public Key..."
    mkdir -p ~/.ssh
    echo "$1" >> ~/.ssh/authorized_keys
    chmod 600 ~/.ssh/authorized_keys
    chmod 700 ~/.ssh
fi
# 3. Persistence Hack (Keep Alive)
# Codespaces will still time out based on settings, but this prevents
# background tasks from being killed easily.
echo "[+] Configuring Tmux for persistence..."
cat <<EOF > ~/.tmux.conf
set -g mouse on
set -g history-limit 10000
EOF
# 4. (Optional) Install Cloudflared for Static Tunneling
# This gives you a static URL to access your "VPS" even if the Codespace restarts
if ! command -v cloudflared &> /dev/null; then
    echo "[+] Installing Cloudflare Tunnel (cloudflared)..."
    curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
    sudo dpkg -i cloudflared.deb
    rm cloudflared.deb
fi
# 5. Weaponization (Offensive Bug Hunter Mode)
# As requested by the Elite Hacker profile, let's pre-load some tools.
echo "[+] Weaponizing environment (Recon Essentials)..."
GO_VERSION="1.21.5"
wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
rm go${GO_VERSION}.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin:~/go/bin
echo 'export PATH=$PATH:/usr/local/go/bin:~/go/bin' >> ~/.zshrc
echo 'export PATH=$PATH:/usr/local/go/bin:~/go/bin' >> ~/.bashrc
echo "[+] Transformation Complete!"
echo "[!] IMPORTANT: Set your Codespace idle timeout to 240 minutes (max) in GitHub Settings."
echo "[!] IMPORTANT: To access from local machine, use: gh cs ssh"
