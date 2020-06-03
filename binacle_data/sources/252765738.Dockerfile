FROM node:6  
RUN apt-get update && apt-get install -y gnupg curl unzip zip  
WORKDIR /tmp  
  
# Create a directory where our app will be placed  
RUN mkdir -p /usr/src/app  
  
# Change directory so that our commands run inside this new directory  
WORKDIR /usr/src/app  
  
# Copy dependency definitions  
COPY package.json /usr/src/app  
  
# Clean cache  
RUN npm cache clean  
  
# Install dependecies  
RUN npm install -g @angular/cli  
RUN npm install  
  
# Get all the code needed to run the app  
COPY . /usr/src/app  
# Expose the port the app runs in  
EXPOSE 4200  
# Serve the app  
CMD ["ng", "serve"]  

