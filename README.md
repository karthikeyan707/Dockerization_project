Containerized Web Application using Docker

A simple Node.js Express web app fully containerized with Docker and deployed on AWS EC2.
This project demonstrates Dockerfile creation, multi-stage builds, image optimization, Docker Hub publishing, and cloud deployment.


📁 Project Structure
app/         → Node.js source  
Dockerfile   → Multi-stage build  
scripts/     → Build, run, deploy scripts  



🚀 Features

Multi-stage Dockerfile (small, optimized image)

Local build + run scripts

Push image to Docker Hub

Deploy container on EC2 (Docker runtime)



🛠 Tech Stack

Node.js (Express)

Docker

Linux (Ubuntu EC2)

Shell scripting



▶️ Run Locally
./scripts/run-local.sh

or manually:
docker build -t webapp:local .
docker run -p 3000:3000 webapp:local

📦 Build & Push to Docker Hub
./scripts/build-and-push.sh v1.0.0



☁️ Deploy on EC2

Install Docker on EC2

Pull your image:

docker pull yourdockerhubusername/containerize-webapp:latest


Run container:

docker run -d -p 80:3000 yourdockerhubusername/containerize-webapp:latest
