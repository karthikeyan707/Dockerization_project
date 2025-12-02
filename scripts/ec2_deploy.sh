#!/usr/bin/env bash
set -euo pipefail

EC2_USER="ubuntu"
EC2_IP="54.185.46.135"
KEY_PATH="~/ssh_key/tata-key.pem"
IMAGE="ukarthikeyan/dockerize-webapp:latest"

ssh -tt -i "${KEY_PATH}" "${EC2_USER}@${EC2_IP}" << 'EOF'
set -e

sudo apt-get update -y
sudo apt-get install -y ca-certificates curl gnupg lsb-release

sudo mkdir -p /etc/apt/keyrings
sudo chmod 755 /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo tee /etc/apt/keyrings/docker.gpg > /dev/null
sudo chmod a+r /etc/apt/keyrings/docker.gpg

UBUNTU_CODENAME=$(lsb_release -cs)
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $UBUNTU_CODENAME stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo usermod -aG docker ubuntu

newgrp docker <<EONG
docker version
docker pull '$IMAGE'
docker rm -f containerize-webapp 2>/dev/null || true
docker run -d --name containerize-webapp -p 80:3000 --restart unless-stopped '$IMAGE'
docker ps
EONG

echo "Deployment Successful!"
EOF

