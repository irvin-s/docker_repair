FROM didstopia/base:steamcmd-ubuntu-16.04  
MAINTAINER Didstopia <support@didstopia.com>  
  
# Fixes apt-get warnings  
ARG DEBIAN_FRONTEND=noninteractive  
  
# Install dependencies  
RUN apt-get update && \  
apt-get install -y --no-install-recommends \  
net-tools \  
expect \  
mono-complete && \  
rm -rf /var/lib/apt/lists/*  
  
# Create and set the steamcmd folder as a volume  
RUN mkdir -p /steamcmd/colonysurvival  
VOLUME ["/steamcmd/colonysurvival"]  
  
# Add the steamcmd installation script  
ADD install.txt /install.txt  
  
# Copy any scripts  
ADD start.sh /start.sh  
ADD server.sh /server.sh  
  
# Set the current working directory  
WORKDIR /  
  
# Expose necessary ports  
EXPOSE 27016/tcp  
EXPOSE 27016/udp  
EXPOSE 27017/tcp  
  
# Setup default environment variables for the server  
ENV SERVER_NAME "Docker"  
ENV SERVER_EXTRA_ARGS ""  
# Start the server  
ENTRYPOINT ["./start.sh"]  

