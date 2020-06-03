# Start with base image from official
FROM node:6.9.2-alpine
MAINTAINER duytran
# Change workdir
WORKDIR /app
# Add current src and install file
ADD src src
ADD package.json package.json
# Run update and install package for application
RUN npm update
# Start application
CMD node src/index.js
