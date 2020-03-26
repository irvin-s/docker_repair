# Select linux install with basic nodejs  
FROM node:argon  
  
# Create app directory  
RUN mkdir -p /usr/src/app/twilio-contact-center-docker  
WORKDIR /usr/src/app/twilio-contact-center-docker  
  
# Install app dependencies  
ADD . /usr/src/app/twilio-contact-center-docker/  
  
RUN npm install  
  
ENV port 5000  
EXPOSE 5000  
CMD [ "npm", "start" ]  

