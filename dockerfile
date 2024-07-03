FROM openjdk:17-jdk-alpine

WORKDIR /minecraft

# Install curl
RUN apk add --no-cache curl

# Download Fabric installer
RUN curl -OJ https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.11.2/fabric-installer-0.11.2.jar

# Install Fabric server
RUN java -jar fabric-installer-0.11.2.jar server -mcversion 1.20.1 -downloadMinecraft

# Create and configure server properties
RUN echo "eula=true" > eula.txt

COPY server.properties .

# Create mods directory
RUN mkdir mods

# Copy mods from host to container
COPY mods/* mods/

EXPOSE 25565

CMD ["java", "-Xmx4G", "-jar", "fabric-server-launch.jar", "nogui"]