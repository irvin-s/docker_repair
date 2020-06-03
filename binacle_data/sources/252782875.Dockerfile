FROM node:4.8.4  
MAINTAINER David Lemaitre  
  
ENV GRUNT_VERSION 0.1.13  
ENV BOWER_VERSION 1.8.0  
ENV GLUE_VERSION 0.13  
ENV NPM_CONFIG_LOGLEVEL warn  
  
# Install requirements for Bower & Glue  
RUN apt-get update && apt-get install -y --no-install-recommends \  
git \  
build-essential \  
libjpeg62-turbo \  
libjpeg62-turbo-dev \  
zlib1g-dev \  
python-dev \  
python-pip \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/*  
  
# Install Grunt & Bower  
RUN npm install -g \  
grunt-cli@"$GRUNT_VERSION" \  
bower@"$BOWER_VERSION"  
  
# Install Glue  
RUN pip install glue=="$GLUE_VERSION"  
  
# Allow running bower as root  
RUN echo '{ "allow_root": true }' > /root/.bowerrc  
  
# Create app directory  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  

