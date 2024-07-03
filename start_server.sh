#!/bin/bash

# Create Docker volumes
docker volume create minecraft-data
docker volume create minecraft-mods

# Build the Docker image
docker build -t minecraft-server . || { echo "Docker build failed"; exit 1; }

# Stop and remove the existing container if it's running
docker stop mc-server >/dev/null 2>&1
docker rm mc-server >/dev/null 2>&1

# Start the Minecraft server
docker run -d -p 25565:25565 --name mc-server \
    -v minecraft-data:/minecraft/world \
    -v minecraft-mods:/minecraft/mods \
    --restart unless-stopped \
    minecraft-server || { echo "Docker run failed"; exit 1; }

# Check if playit exists and is executable
if [ ! -x "./playit" ]; then
    echo "playit is not executable or doesn't exist"
    exit 1
fi

# Start playit.gg
./playit