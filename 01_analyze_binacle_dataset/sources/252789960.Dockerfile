# Based on the Ubuntu 14.04  
FROM node:7.9.0  
LABEL maintainer="camerondubas@gmail.com"  
  
# Make directory for the app  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
COPY package.json /usr/src/app/  
RUN npm install  
# Copy the app code  
COPY . /usr/src/app/  
  
# Start the server  
CMD ["npm", "run", "start"]  
  
EXPOSE 3000

