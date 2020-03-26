# GENERATED FILE -- DO NOT EDIT.  
# See Dockerfile.apt.tmpl  
FROM ubuntu:precise  
MAINTAINER qa@docker.com  
  
CMD curl  
RUN apt-get update \  
&& apt-get install -y curl apt-transport-https gnupg \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/*  

