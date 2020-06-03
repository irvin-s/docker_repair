FROM beevelop/nodejs:6  
MAINTAINER Maik Hummel <m@ikhummel.com>  
  
# Install Python.  
RUN \  
apt-get update && \  
apt-get install -y python python-dev python-pip python-virtualenv && \  
rm -rf /var/lib/apt/lists/*  

