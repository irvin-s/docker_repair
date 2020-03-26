FROM bradleybossard/docker-common-devbox  
MAINTAINER Bradley Bossard <bradleybossard@gmail.com>  
  
# Build the image  
# docker build --rm -t docker-node-devbox .  
# Fire up an instance with a bash shell  
# docker run --rm -i -t docker-node-devbox  
RUN apt-get update --fix-missing  
  
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -  
  
RUN apt-get install -y nodejs pkg-config libcairo2-dev \  
libjpeg8-dev libpango1.0-dev libgif-dev build-essential g++  
  
RUN npm install -g webpack \  
webpack-dev-server \  
bower \  
gulp \  
grunt \  
node-inspector \  
jspm \  
live-server \  
typescript \  
typings \  
nativescript \  
nodemon \  
eslint \  
browserify \  
watchify \  
babelify  

