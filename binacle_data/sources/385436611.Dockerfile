FROM ubuntu:14.04
ENV	DEBIAN_FRONTEND noninteractive

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN echo "deb http://overviewer.org/debian ./" >> /etc/apt/sources.list
RUN apt-get update

RUN apt-get install wget -y

# install Overviewer - http://docs.overviewer.org/en/latest/installing/
RUN wget -O - http://overviewer.org/debian/overviewer.gpg.asc | apt-key add -
RUN apt-get install minecraft-overviewer -y --force-yes

# Overviewer needs Minecraft textures to generate maps
# Let's download them for a specific version:
ENV VERSION 1.11
RUN wget --no-check-certificate https://s3.amazonaws.com/Minecraft.Download/versions/${VERSION}/${VERSION}.jar -P ~/.minecraft/versions/${VERSION}/

WORKDIR /srv

# Add config and start script
COPY start.sh start.sh
COPY config-initial config-initial

ENTRYPOINT ["/bin/bash","./start.sh"]