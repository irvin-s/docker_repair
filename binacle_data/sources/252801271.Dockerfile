FROM node:4.1.2-slim  
MAINTAINER dylanmei "https://github.com/dylanmei"  
RUN npm install -g jade@1.11.0  
ENTRYPOINT ["/usr/local/bin/jade"]  

