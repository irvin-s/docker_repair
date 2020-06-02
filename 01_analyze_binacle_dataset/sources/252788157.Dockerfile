FROM node:8.7.0  
MAINTAINER Alexander Sosna <alexander.sosna@credativ.de>  
  
RUN \  
apt-get update && \  
apt-get -y install rsync && \  
npm install -g yo gulp-cli bower generator-webapp  
  
CMD ["bash"]  

