FROM alpine as fetch  
  
RUN apk add --no-cache \  
ca-certificates \  
curl &&\  
cd /tmp &&\  
curl -sSL -O https://master.dockerproject.org/linux/x86_64/docker.tgz &&\  
tar xzf docker.tgz  
  
FROM area51/java:serverjre-8  
MAINTAINER Peter Mount <peter@retep.org>  
  
ENV DOCKER_VERSION 1.11.0  
COPY \--from=fetch /tmp/docker /docker  
  
RUN apk add --no-cache \  
ca-certificates \  
openssh &&\  
ln -s /docker/docker /usr/bin/docker  

