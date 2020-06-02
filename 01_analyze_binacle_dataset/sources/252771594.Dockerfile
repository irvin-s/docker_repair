FROM debian:jessie  
  
RUN apt-get -y update && \  
apt-get -y install devscripts debhelper dh-systemd && \  
rm -rf /var/lib/apt/lists/*  
  
WORKDIR /workspace  
VOLUME /workspace  
  
ENTRYPOINT ["debuild"]  

