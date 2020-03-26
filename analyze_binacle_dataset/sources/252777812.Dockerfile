# Select source image  
FROM node:wheezy  
  
# Install all dependencies  
RUN apt-get update -q && apt-get upgrade -y --no-install-recommends  
  
# Create app directories  
RUN mkdir -p /usr/app/config  
WORKDIR /root  
  
# We download the OPAL algo service  
RUN git clone -b master https://github.com/aoehmichen/OPAL-AlgoService  
  
WORKDIR /root/OPAL-AlgoService  
  
# Bundle app  
RUN cp package.json /usr/app/ \  
&& cp -r src /usr/app/src  
  
WORKDIR /usr/app  
  
# We create the folder for the savePath  
RUN mkdir data  
  
# Install opal-algoservice npm dependencies  
RUN npm install; exit 0;  
RUN cat /root/.npm/_logs/*; exit 0;  
  
# Run compute service  
EXPOSE 80  
CMD [ "npm", "start" ]  

