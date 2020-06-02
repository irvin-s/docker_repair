FROM node:6  
MAINTAINER xun "me@xun.my"  
  
RUN npm install -g gulp  
  
# ENTRYPOINT ["/usr/local/bin/gulp"]  
  
# CMD ["gulp", "--help"]  
# docker build -t axnux/node-gulp:latest . #  

