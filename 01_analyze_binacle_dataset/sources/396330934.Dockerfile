
# We use debian as our base distro for this container.
FROM debian:latest

# Refresh apt-get.
RUN apt-get update

# Install some utilities needed by node, npm, and ZeroMQ.
RUN apt-get install -y curl make g++

# Install Node.js and npm.
RUN curl -sL https://deb.nodesource.com/setup | bash -
RUN apt-get install -y nodejs

# Install ZeroMQ libs.
RUN apt-get install -y libzmq-dev

# Install some perf test tools.
RUN apt-get install -y fio iperf

# Install required npm packages.
ADD package.json /package.json
RUN npm install

# Set /src as the working directory for this container.
WORKDIR /src

# Open up external access to port 80.
EXPOSE  80

# Run startup command.
CMD ["node", "/src/scripts/server.js"]
