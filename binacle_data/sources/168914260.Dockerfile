FROM node:latest

# Maintainer
LABEL maintainer="Paweł Partyka <partyka950@gmail.com>"

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Copy package.json
COPY package.json /usr/src/app/

# Install dependencies
RUN npm install

# Bundle app source
COPY . /usr/src/app

# Expose port
EXPOSE 80

# Run app
CMD npm run start:dev
