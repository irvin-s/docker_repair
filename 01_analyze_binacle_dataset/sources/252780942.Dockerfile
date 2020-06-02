FROM buildpack-deps:jessie  
  
RUN apt-get update && \  
apt-get install rsync -y  
  

