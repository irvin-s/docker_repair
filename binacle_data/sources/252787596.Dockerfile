#FROM xeor/wetty  
FROM ubuntu:14.04.2  
MAINTAINER brownman "ofer.shaham@gmail.com"  
#https://hub.docker.com/r/brownman/root/builds/  
USER root  
ENV HOME /root  
WORKDIR /root  
  
ENV TERM xterm-256color  
  
# Install node & npm  
RUN apt-get -qqy update && \  
DEBIAN_FRONTEND=noninteractive apt-get -y install vim git nodejs npm \  
curl wget \  
ssh \  
rsync \  
figlet \  
xsel \  
toilet \  
pv \  
tree \  
screen \  
sudo  
  
RUN ln -s /usr/bin/nodejs /usr/bin/node  
  
#RUN curl https://www.npmjs.com/install.sh | clean=no sh  
RUN git clone https://github.com/nathanleclaire/wetty.git && \  
cd wetty && \  
npm install  
  
RUN sed 's@/bin/login@/bin/bash@' -i /root/wetty/app.js  
  
#  
EXPOSE 3002  
RUN echo 'test -f /tmp/bashrc && source /tmp/bashrc || true' >> /root/.bashrc  
  
CMD [ "bash" , "-c" , "echo ofer.shaham AT gmail.com" ]  

