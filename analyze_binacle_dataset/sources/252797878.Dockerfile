FROM ubuntu:14.04  
MAINTAINER Code Climate <hello@codeclimate.com>  
  
COPY dockerfile-version /  
  
RUN apt-get update && \  
apt-get install -y \  
keychain openssl ssh && \  
rm -rf /var/lib/apt/lists/*  

