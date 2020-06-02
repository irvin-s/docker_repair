FROM ubuntu:14.04  
RUN apt-get -qq update && \  
DEBIAN_FRONTEND=noninteractive apt-get -y install \  
python2.7 nodejs nodejs-legacy npm \  
> /dev/null && \  
apt-get clean && rm -rf /var/lib/apt/lists/*  
  
RUN npm config set color false; \  
npm config set loglevel warn  
  
COPY package.json /app/package.json  
WORKDIR /app  
RUN npm install  
  
COPY . /app  
  
# note server  
EXPOSE 1947  
CMD ["node", "plugin/notes-server"]  

