#!/bin/bash

# Stop the Minecraft server
docker stop mc-server

# Copy new mods to the mods volume
docker run --rm -v minecraft-mods:/mods -v $(pwd)/mods:/new_mods alpine sh -c "rm -rf /mods/* && cp -r /new_mods/* /mods/"

# Start the Minecraft server
docker start mc-server