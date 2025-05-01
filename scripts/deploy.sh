#!/bin/bash

set -e

# Variables
IMAGE_NAME=ai-server-image
ECR_URI=014498634556.dkr.ecr.ap-south-1.amazonaws.com/akhil-ai-server
AWS_REGION=ap-south-1
CONTAINER_NAME=ai-server

echo "Logging in to ECR..."
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_URI

echo "Stopping and removing existing container..."
docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true

echo "Pulling latest image..."
docker pull $ECR_URI/$IMAGE_NAME:latest

echo "Starting new container..."
docker run -d --name $CONTAINER_NAME -p 8000:8000 $ECR_URI/$IMAGE_NAME:latest

echo "Deployment complete."
