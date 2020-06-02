# Set the base image to Node 9
FROM node:9

# File Author / Maintainer
MAINTAINER Brayton Stafford

# Provides cached layer for node_modules
ADD package.json /tmp/package.json
RUN cd /tmp && npm install
RUN mkdir -p /src && cp -a /tmp/node_modules /src/

# Define working directory
WORKDIR /src
ADD . /src

# Expose port
EXPOSE  4000

# Run app using npm
CMD ["npm", "start"]
