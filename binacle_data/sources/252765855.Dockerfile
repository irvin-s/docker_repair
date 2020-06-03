FROM node:8-alpine  
  
ARG AJV_CLI_VERSION=3.0.0  
RUN npm install -g ajv-cli@${AJV_CLI_VERSION}  
  
VOLUME ["/data"]  
WORKDIR "/data"  
  
ENTRYPOINT ["/usr/local/bin/ajv"]  

