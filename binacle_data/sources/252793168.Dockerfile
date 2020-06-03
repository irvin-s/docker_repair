FROM mhart/alpine-node:6.10  
MAINTAINER chief@beefdisciple.com  
  
ENV WD=/opt/hubot  
  
WORKDIR $WD  
  
RUN mkdir -p $WD  
  
COPY . $WD  
  
RUN \  
npm install --production  
  
CMD bin/hubot -a slack  

