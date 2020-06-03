FROM node:8-alpine  
  
ENV CI_HOME /usr/local/chip-in  
  
RUN apk --update add pcre-dev openssl-dev curl git  
RUN mkdir -p ${CI_HOME}/ \  
&& cd ${CI_HOME} \  
&& git clone https://github.com/chip-in/resource-node.git resource-node \  
&& cd ${CI_HOME}/resource-node \  
&& npm i \  
&& npm run cleanbuild \  
&& cd ${CI_HOME}/resource-node/examples/static-files-server \  
&& npm i \  
&& npm run cleanbuild  
  
WORKDIR ${CI_HOME}/resource-node/examples/static-files-server  
  
ENTRYPOINT ["npm", "start", "--"]  
  

