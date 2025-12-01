#!/usr/bin/env bash

set -euo pipefail
echo "SCRIPT RUNNING IN: $(pwd)"
DOCKERHUB_USER="ukarthikeyan"
IMAGE_NAME="dockerize-webapp"
TAG="${1:-v1}" 

echo "Building image..."
docker build -t "${DOCKERHUB_USER}/${IMAGE_NAME}:${TAG}" .

docker tag "${DOCKERHUB_USER}/${IMAGE_NAME}:${TAG}" "${DOCKERHUB_USER}/${IMAGE_NAME}:latest"

echo "Logging into Docker Hub..."
docker login

echo "Pushing images..."
docker push "${DOCKERHUB_USER}/${IMAGE_NAME}:latest"

echo "Done. Pushed ${DOCKERHUB_USER}/${IMAGE_NAME}:${TAG}"
