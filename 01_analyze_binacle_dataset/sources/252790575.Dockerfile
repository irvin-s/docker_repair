FROM node:5.12  
# Install gulp globally  
RUN npm install gulp -g  
  
# Create an app directory  
RUN mkdir /app  
  
# This directory is used by npm. It is not exposed.  
RUN mkdir /.npm  
RUN chmod 777 /.npm  
  
# Exposed port 3000 (common default for express apps) and app directory  
EXPOSE 3000  
WORKDIR /app  
  
CMD [ "gulp" ]  

