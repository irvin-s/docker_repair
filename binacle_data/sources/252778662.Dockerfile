# Dockerfile is based on NodeJS 6.0 Image  
FROM node:6  
# Create our application directory.  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
COPY package.json /usr/src/app/  
  
# Install our NPM modules from package.json  
RUN npm i --production  
  
# Install forever so we can run our application  
RUN npm i -g forever  
  
# Add volumes  
RUN mkdir /database  
VOLUME /database  
  
# Expose the ports  
EXPOSE 2055  
EXPOSE 2056  
EXPOSE 8020  
# Set the default database location.  
ENV DDWARDEN_DATABASE /database/ddwarden.db  
  
# Start the DDWarden Application with Forever.  
CMD ["forever", "index.js"]  
  
# Copy the rest of the application files  
COPY . /usr/src/app

