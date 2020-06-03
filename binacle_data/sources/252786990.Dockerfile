#  
# AMP Dockerfile  
#  
# https://github.com/othrayte/docker-cc-amp  
#  
# Pull base image.  
FROM debian:jessie-backports  
  
# Install dependencies  
RUN apt-get update && apt-get install -y \  
lib32gcc1 \  
coreutils \  
screen \  
tmux \  
socat \  
unzip \  
git \  
wget \  
openjdk-8-jre \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN \  
groupadd -r AMP && \  
useradd -r -g AMP -d /home/AMP -m AMP && \  
mkdir /home/AMP/AMP && \  
cd /home/AMP/AMP && \  
wget http://cubecoders.com/Downloads/ampinstmgr.zip && \  
unzip ampinstmgr.zip && \  
rm -fi \--interactive=never ampinstmgr.zip  
  
# Define working directory.  
WORKDIR /home/AMP/AMP  
  
COPY start.sh /home/AMP/AMP/  
  
RUN \  
mkdir /ampdata && \  
chown AMP:AMP /ampdata && \  
chown AMP:AMP ./start.sh && \  
chmod +x ./start.sh  
  
VOLUME ["/ampdata"]  
VOLUME ["/minecraft"]  
  
USER AMP  
  
# Define default command.  
ENTRYPOINT ["./start.sh"]  
  
RUN ln -s /ampdata /home/AMP/.ampdata  
  
# Expose ports.  
EXPOSE 8080  

