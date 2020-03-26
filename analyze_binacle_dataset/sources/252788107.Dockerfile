#  
# Custom docker-in-docker image for GitLab-CI  
#  
# Written by:  
# Baptiste MOINE <contact@bmoine.fr>  
#  
  
# Pull base image.  
FROM docker:dind  
  
MAINTAINER Baptiste MOINE <contact@bmoine.fr>  
  
ENV REGISTRY=registry.docker.lab  
COPY ca.crt /tmp/ca.crt  
RUN install -D /tmp/ca.crt /etc/docker/certs.d/${REGISTRY}/ca.crt && \  
install -D /tmp/ca.crt /usr/local/share/ca-certificates/ca.crt && \  
cat /tmp/ca.crt >>/etc/ssl/certs/ca-certificates.crt && \  
rm /tmp/ca.crt  
  

