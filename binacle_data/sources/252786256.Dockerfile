FROM node:8.4.0-alpine  
  
# Create a directory where our app will be placed  
RUN mkdir -p /usr/src/app  
  
# Change directory so that our commands run inside this new directory  
WORKDIR /usr/src/app  
  
# Copy dependency definitions  
COPY package.json *.js /usr/src/app/  
  
# Install dependecies  
RUN npm install --production  
  
# Expose the port the app runs in  
EXPOSE 9207  
# Serve the app  
CMD ["node", "index.js"]

