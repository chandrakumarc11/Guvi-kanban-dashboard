# Kanban Dashboard CI/CD Deployment

## Project Overview

React + Vite Application deployed using:

- Docker
- Jenkins
- AWS EC2
- Docker Hub

## Architecture

GitHub
↓
Jenkins
↓
Docker Build
↓
Docker Hub
↓
EC2 Deployment
↓
Health Check

## Setup Steps

1. Clone Repository
2. Install Dependencies
3. Build Docker Image
4. Push to Docker Hub
5. Jenkins Pipeline Setup
6. GitHub Webhook Setup

## Application URL

http://<EC2-PUBLIC-IP>:3000

## Docker Hub Repository

https://hub.docker.com/r/chandru04/kanban-dashboard
