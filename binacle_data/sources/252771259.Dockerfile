# BUILD-USING: docker build -t airburst/cf-graphql:latest .  
# RUN-USING: docker run -d -p 4000:4000 airburst/cf-graphql  
FROM collinestes/docker-node-oracle:latest  
  
# Create app directory  
RUN mkdir -p /usr/app  
WORKDIR /usr/app  
  
# Install app dependencies  
COPY package.json /usr/app/  
RUN npm install  
  
# Bundle app source  
COPY . /usr/app  
  
# Make logfiles available outside container  
VOLUME ["/usr/app/logs"]  
  
EXPOSE 4000  
CMD [ "npm", "start" ]  

