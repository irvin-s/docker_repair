FROM node:slim  
MAINTAINER damilolasodiq <damilolasodiq@gmail.com>  
RUN apt-get update && apt-get install -y --no-install-recommends \  
openssh-client \  
&& rm -rf /var/lib/apt/lists/*

