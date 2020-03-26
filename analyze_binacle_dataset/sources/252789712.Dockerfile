FROM mhart/alpine-node:5  
WORKDIR /opt  
  
RUN apk --update add git  
  
ADD package.json /opt/package.json  
RUN npm install --production  
  
ADD . /opt  
CMD ["node", "bin/sidecar.js"]  

