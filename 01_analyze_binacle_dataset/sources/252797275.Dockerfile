FROM ubuntu:16.04  
LABEL maintainer="Shinji Kawaguchi <shinji.kawaguchi@clouto.io>" \  
version="0.1" \  
description="nginx and node.js"  
  
RUN apt-get update  
RUN apt-get install -y curl  
RUN apt-get install -y nginx  
RUN apt-get install -y nodejs npm  
RUN npm install n -g \  
&& n stable \  
&& ln -sf /usr/local/bin/node /usr/bin/node  
  
CMD ["nginx", "-g", "daemon off;"]  

