FROM ubuntu:14.04  
MAINTAINER Chris Jeong <crowjdh@gmail.com>  
  
RUN apt-get update &&\  
apt-get install -y \  
curl \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN curl -sL \  
https://deb.nodesource.com/setup_4.x | bash - &&\  
rm -rf /var/lib/apt/lists/*  
  
RUN apt-get update &&\  
apt-get install -y \  
nodejs \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN mkdir -p /usr/src/app  
COPY . /usr/src/app  
WORKDIR /usr/src/app  
  
RUN npm install  
  

