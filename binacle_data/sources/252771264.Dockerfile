# BUILD-USING: docker build -t airburst/eclipse-proxy:latest .  
# RUN-USING: docker run -d -p 3001:3001 airburst/eclipse-proxy  
FROM mhart/alpine-node:latest  
  
# Create app directory  
RUN mkdir -p /usr/app  
WORKDIR /usr/app  
  
# Install app dependencies  
COPY package.json /usr/app/  
RUN npm install  
  
# Bundle app source  
COPY . /usr/app  
  
# Build the app  
# RUN npm run build  
# Make logfiles available outside container  
VOLUME ["/usr/app/logs"]  
  
EXPOSE 3001  
CMD [ "node", "/usr/app/bin.js" ]  

