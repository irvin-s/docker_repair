FROM dwimberger/alpine-dmtx-pm2:latest  
  
# Create app directory  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
# Bundle app source  
COPY . /usr/src/app  
  
# Install app dependencies  
RUN npm install  
  
EXPOSE 8080  
# Start the application  
CMD ["pm2-docker", "start", "--auto-exit", "process.yml"]  

