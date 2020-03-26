FROM node:0.10.32  
MAINTAINER Ron Waldon <jokeyrhyme@gmail.com>  
  
RUN npm install -g bower@1.3.12  
  
ENTRYPOINT ["bower"]  

