FROM node:6.3.0  
MAINTAINER Florent Bourgeois <florent@creative-area.net>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update && apt-get install -y default-jre  
  
RUN mkdir -p /usr/src/app  
  
WORKDIR /usr/src/app  
  
CMD [ "node" ]  

