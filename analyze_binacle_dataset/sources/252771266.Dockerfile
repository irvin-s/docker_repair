FROM mhart/alpine-node:latest  
  
# Create app directory  
RUN mkdir -p /usr/app  
WORKDIR /usr/app  
  
# Install app dependencies  
# COPY package.json /usr/app/  
# Bundle app source  
COPY . /usr/app  
  
# Install build dependencies, run npm, then remove  
# the build code from image  
RUN apk --no-cache add --virtual native-deps \  
g++ gcc libgcc libstdc++ linux-headers make python && \  
npm install --quiet node-gyp -g &&\  
npm install --quiet && \  
apk del native-deps  
  
# Make logfiles available outside container  
VOLUME ["/usr/app/logs"]  
VOLUME ["/usr/app/data"]  
  
EXPOSE 9001  
CMD [ "npm", "start" ]  

