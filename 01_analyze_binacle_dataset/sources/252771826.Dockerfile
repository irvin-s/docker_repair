FROM debian:jessie  
MAINTAINER Adrian Dvergsdal [atmoz.net]  
  
RUN apt-get update && \  
apt-get -y install makepasswd && \  
rm -rf /var/lib/apt/lists/*  
  
ENTRYPOINT ["makepasswd"]  

