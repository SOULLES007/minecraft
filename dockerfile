FROM openjdk:21-jdk-slim

WORKDIR /minecraft

# Install curl

RUN apk add --no-cache curl

# Download Fabric installer

RUN curl -OJ https://maven.fabricmc.net/net/fabricmc/fabric-installer/1.0.1/fabric-installer-1.0.1.jar

# Install Fabric server

RUN java -jar fabric-installer-1.0.1.jar server -mcversion 1.21 -downloadMinecraft

# Create and configure server properties

RUN echo "eula=true" > eula.txt

COPY server.properties .

# Create mods directory

RUN mkdir mods

# Copy mods from host to container

COPY mods/* mods/

EXPOSE 25565

CMD ["java", "-Xmx4G", "-jar", "fabric-server-launch.jar", "nogui"]