FROM node:argon

MAINTAINER "Toshiki Inami <t-inami@arukas.io>"

# Set the applilcation directory
WORKDIR /app

# Install app dependencies
COPY package.json /app
RUN npm install

# Copy our code from the current folder to /app inside the container
COPY . /app

# Make port 3000 available for publish
EXPOSE 3000

# Start server
CMD [ "npm", "start" ]
