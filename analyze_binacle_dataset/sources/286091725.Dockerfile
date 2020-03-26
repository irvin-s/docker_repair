FROM node:8.9

# Create app directory
WORKDIR /usr/app

# Copy the package.json file
COPY package.json .

# Install app dependencies
RUN npm install

# Bundle app source
COPY . .

# Expose app port from docker container
EXPOSE 3002
EXPOSE 8888