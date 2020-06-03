FROM nodesource/jessie:6.3.1  
# Create app directory  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
# Install app dependencies  
COPY package.json /usr/src/app/  
RUN npm install  
  
# Bundle app source  
COPY . /usr/src/app  
  
# Set mongodb username and password as environment variables  
ARG MONGODB_USERNAME  
ARG MONGODB_PASSWORD  
  
ENV MONGODB_USERNAME=$MONGODB_USERNAME  
ENV MONGODB_PASSWORD=$MONGODB_PASSWORD  
  
ENTRYPOINT ["node", "src/beerbets-server.js"]  
  
EXPOSE 3000  

