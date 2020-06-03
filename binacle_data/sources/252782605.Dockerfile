FROM debian:jessie-slim  
  
MAINTAINER Gareth Price <gareth@clearandfizzy.com>  
  
ADD . /app  
WORKDIR /app  
  
RUN export DEBIAN_FRONTEND=noninteractive  
  
# Clean  
# RUN apt-get clean && \  
# update & upgrade  
RUN apt-get update -qy && \  
apt-get upgrade -qy  
  
# Install basics  
RUN apt-get install -qy software-properties-common \  
python \  
zip \  
unzip \  
git-all \  
nano \  
curl \  
wget  
  
# Install other stuff...  
RUN apt-get install -qy mlocate \  
iotop \  
htop \  
rsyslog-gnutls  
  
## Setup some aliases  
#RUN touch /root/.bashrc \  
RUN echo "alias dir='ls -alh'" >> ~/.bashrc  
RUN echo "alias pico='nano -c'" >> ~/.bashrc  
RUN echo "alias npm='npm --no-optional'" >> ~/.bashrc  
  
## Install NodeJS - this installs the correct version  
RUN curl -sL https://deb.nodesource.com/setup_6.x -o nodesource_setup.sh && \  
bash nodesource_setup.sh  
  
RUN apt-get -yq install nodejs tinyproxy  
  
RUN npm install --save react react-dom  
RUN npm install --save webpack  
RUN npm install --save babel-loader babel-preset-es2015 babel-preset-react  
  
## clean apt-get  
RUN apt-get clean  
  
CMD ["/bin/bash"]

