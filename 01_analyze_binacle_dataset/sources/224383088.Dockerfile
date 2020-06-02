FROM ubuntu:14.04.1
MAINTAINER mitchell.simoens@sencha.com

# Install Node v6 and npm
RUN apt-get update
RUN apt-get install -y build-essential curl
RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
RUN apt-get install -y nodejs

# Copy source into this container
ADD . /src

# Install Node modules
RUN cd /src/server; npm install

# Expose port 3000 to the docker container server
EXPOSE 3000

# Start app
CMD ["nodejs", "/src/server/index.js"]
