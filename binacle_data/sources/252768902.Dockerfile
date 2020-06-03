# Angular Flask Boilerplate Docker Setup  
#  
FROM ubuntu:latest  
MAINTAINER Andrew McCracken "andrew@tind.io"  
RUN apt-get update -y  
RUN apt-get install -y python-pip python2.7 build-essential  
  
RUN apt-get -qy install --fix-missing --no-install-recommends --force-yes curl  
  
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -  
  
# Install dependencies  
RUN apt-get -qy --force-yes install --fix-missing --no-install-recommends \  
gcc \  
git \  
less \  
nodejs \  
unzip \  
vim \  
sudo  
  
COPY . /app  
WORKDIR /app  
  
# Install npm packages  
COPY package.json /app/  
RUN npm install  
  
RUN npm run postinstall  
  
RUN pip install -r requirements.txt  

