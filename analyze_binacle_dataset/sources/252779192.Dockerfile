  
FROM bitnami/node:7 as builder  
# Set up VM  
RUN apt-get update && apt-get install -y --no-install-recommends  
# Install GEMS  
RUN apt-get -y install ruby rubygems ruby-dev  
RUN gem install --no-rdoc --no-ri sass -v 3.4.22  
RUN gem install --no-rdoc --no-ri compass  
  
# Install node modules Client  
COPY ./client/package.json /app/client/package.json  
WORKDIR /app/client  
RUN npm install  
RUN npm install bower grunt-cli -g  
  
# Install Bower components Client  
COPY ./client/bower.json /app/client/bower.json  
WORKDIR /app/client  
RUN bower install --allow-root  
  
# Install node modules Server  
COPY ./server/package.json /app/server/package.json  
WORKDIR /app/server  
RUN npm install  
  
# Build application with grunt  
COPY . /app  
WORKDIR /app/client  
RUN grunt build  
  
# Test application  
WORKDIR /app/client  
RUN grunt test  
  
FROM bitnami/node:7-prod  
COPY \--from=builder /app/server /app  
WORKDIR /app  
EXPOSE 3000  
CMD ["npm", "start", "app.js"]  

