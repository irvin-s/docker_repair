FROM docker:dind  
MAINTAINER CodeX Systems <webmaster@codex.systems>  
COPY assets/ /  
  
# Add additional packages  
RUN apk add --no-cache \  
git \  
curl \  
bash  
  
# Install Google Cloud SDK  
RUN curl https://sdk.cloud.google.com | bash

