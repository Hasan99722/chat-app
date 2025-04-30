#!/bin/bash

set -e

# Variables
IMAGE_NAME=testapp
ECR_URI=762233754891.dkr.ecr.us-east-1.amazonaws.com/testapp
AWS_REGION=us-east-1
CONTAINER_NAME=test-server

echo "Logging in to ECR..."
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_URI

echo "Stopping and removing existing container..."
docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true

echo "Pulling latest image..."
docker pull $ECR_URI/$IMAGE_NAME:latest

echo "Starting new container..."
docker run -d --name $CONTAINER_NAME -p 80:80 $ECR_URI/$IMAGE_NAME:latest

echo "Deployment complete."
