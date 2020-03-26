FROM node:5  
MAINTAINER Chris Tankersley <chris@ctankersley.com>  
  
WORKDIR /data  
ENV HOME=/data  
  
RUN npm install -g bower grunt-cli && npm set cache /data/.npm --global  
  
CMD ["bash"]

