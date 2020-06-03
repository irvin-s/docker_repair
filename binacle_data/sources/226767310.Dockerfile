# Set the base image to Ubuntu
FROM node:6.10

# Create app directory
RUN mkdir -p /usr/src/app

# Default dir
WORKDIR /usr/src/app

# Install nodemon
RUN npm install -g nodemon

# Copy package
COPY package.json /usr/src/app/

# Install app dependencies
RUN npm cache clean && npm install --silent --progress=false

# Bundle app source
COPY . /usr/src/app

# Expose port
EXPOSE  8080

# Run app using nodemon
CMD ["nodemon", "/usr/src/app/server.js"]
