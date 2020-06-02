FROM debian:jessie  
MAINTAINER Allan Espinosa "allan.espinosa@outlook.com"  
RUN apt-get update && \  
apt-get \--no-install-recommends install -y mpich && \  
apt-get clean  

