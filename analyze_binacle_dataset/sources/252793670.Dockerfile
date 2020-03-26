############################################################  
# Dockerfile to build Google Cloud images  
# Based on Debian Jessie  
############################################################  
  
# Set the base image to Ubuntu  
FROM launcher.gcr.io/google/debian8:latest  
  
# File Author  
MAINTAINER Chip Oglesby  
  
# Prepare the image.  
ENV DEBIAN_FRONTEND noninteractive  
RUN apt-get update && \  
apt-get install -y -qq --no-install-recommends \  
git \  
wget \  
nano \  
sudo \  
unzip \  
python \  
php5-mysql \  
php5-cli \  
php5-cgi \  
openjdk-7-jre-headless \  
openssh-client \  
python-openssl && \  
apt-get clean && \  
git clone https://github.com/chipoglesby/encryptedDashboard.git  

