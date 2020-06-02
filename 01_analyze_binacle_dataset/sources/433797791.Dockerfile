FROM node:0.10.40
MAINTAINER Akvo Foundation <devops@akvo.org>

# Capture build-time variable
ARG env=development
ARG v=2.6.1

# Install build dependencies
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    libpango1.0-dev \
    libgif-dev \
    libcairo2-dev \
    libmapnik2.2 libmapnik-dev python-mapnik mapnik-utils && \
    rm -rf /var/lib/apt/lists/*

# Install Windshaft
RUN git clone git://github.com/CartoDB/Windshaft-cartodb.git && \
    cd Windshaft-cartodb && \
    git checkout tags/$v && \
    npm install && \
    mkdir logs

# Create configuration
ADD ./config/WS-$env.js \
    /Windshaft-cartodb/config/environments/$env.js

# Start the service
WORKDIR /Windshaft-cartodb
# using shell form to enable variable substituion
ENTRYPOINT node app.js $env
