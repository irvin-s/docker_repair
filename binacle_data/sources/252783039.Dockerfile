FROM node:9  
  
RUN apt-get update && \  
apt-get install -y python python-dev python-pip python-virtualenv  
  
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global  
ENV PATH="${NPM_CONFIG_PREFIX}/bin:${PATH}"  
  
WORKDIR /app  
  
USER root  
  
RUN apt update &&\  
apt install -y jq  
  
ADD vsts-import.js /app  
ADD vsts-build.js /app  
ADD vsts-release.js /app  
ADD vsts-getbuilddef.js /app  
ADD vsts-getservices.js /app  
ADD api.js /app  
ADD package.json /app  
  
RUN npm install -g  
  
RUN pip install yq  
  
USER node  

