################################  
# #  
# DOCKERFILE #  
# Hybrid Assembly Pipeline #  
# #  
################################  
  
FROM debian:jessie  
MAINTAINER mail@caspar.one  
  
# Commont applications  
RUN apt-get update && apt-get install --yes --no-install-recommends \  
wget \  
locales \  
vim-tiny \  
git \  
cmake \  
build-essential \  
gcc-multilib \  
perl \  
python  
  
# Install JAVA 8  
  
# Install SPAdes  
  
#  
  
# Set current working directory to /app  
WORKDIR /app  
  
# Copy the current directory contents into the container at /app  
  
  

