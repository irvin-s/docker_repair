FROM borrowshare/borrow-api:master  
  
# Install app dependencies  
COPY package.json /src/package.json  
RUN cd /src; rm -rf node_modules; npm install; npm update; npm install -g npm;  
  
# Bundle app source  
COPY . /src  
  
EXPOSE 6050  
WORKDIR "/src"  
CMD ["node", "./server.js"]  
  
# RUN ./autoRestart.sh  

