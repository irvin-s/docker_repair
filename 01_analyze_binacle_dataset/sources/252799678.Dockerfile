FROM didstopia/base:nodejs-steamcmd-ubuntu-16.04  
MAINTAINER Didstopia <support@didstopia.com>  
  
# Fixes apt-get warnings  
ARG DEBIAN_FRONTEND=noninteractive  
  
# Install dependencies  
RUN apt-get update && \  
apt-get install -y --no-install-recommends \  
net-tools && \  
rm -rf /var/lib/apt/lists/*  
  
# Create and set the steamcmd folder as a volume  
RUN mkdir -p /steamcmd/stationeers  
VOLUME ["/steamcmd/stationeers"]  
  
# Add the steamcmd installation script  
ADD install.txt /install.txt  
  
# Copy the startup script  
ADD start_stationeers.sh /start.sh  
  
# Set the current working directory  
WORKDIR /  
  
# Setup default environment variables for the server  
ENV STATIONEERS_SERVER_STARTUP_ARGUMENTS "-autostart -nographics -batchmode"  
ENV STATIONEERS_SERVER_NAME "A Docker Server"  
ENV STATIONEERS_WORLD_NAME "docker"  
ENV STATIONEERS_SERVER_SAVE_INTERVAL "300"  
ENV STATIONEERS_GAME_PORT "27500"  
ENV STATIONEERS_QUERY_PORT "27015"  
# Expose necessary ports  
EXPOSE 27500/tcp  
EXPOSE 27500/udp  
EXPOSE 27015/udp  
  
# Start the server  
ENTRYPOINT ["./start.sh"]  

