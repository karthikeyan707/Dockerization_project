#!/usr/bin/env bash

set -euo pipefail


EC2_USER="ubuntu"
EC2_IP=""
KEY_PATH="~/ssh_key/tata-key.pem"
IMAGE="ukarthikeyan/dockerize-webapp:latest"

ssh -i "${KEY_PATH}" "${EC2_USER}@${EC2_IP}" <<EOF
  set -e
  sudo apt-get update -y
  sudo apt-get install -y ca-certificates curl gnupg lsb-release
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker -archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update -y
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io
  sudo usermod -aG docker ubuntu
  sudo docker pull ${IMAGE}
  sudo docker run -d --name containerize-webapp -p 80:3000 --restart unless-stopped ${IMAGE}
  echo "Deployed ${IMAGE}"
EOF

