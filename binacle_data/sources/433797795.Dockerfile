# engine cartodb-psql@0.6.0: wanted: {"node":">= 0.8 < 0.11"}
FROM node:0.10.40
MAINTAINER Akvo Foundation <devops@akvo.org>

# Capture build-time variable
ARG env=development
ARG v=1.23.0

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    zip \
    gdal-bin \
    libgdal1-dev \
    libxml2-dev \
    libxslt-dev && \
    rm -rf /var/lib/apt/lists/*

# Install CartoDB API and its dependencies
RUN git clone git://github.com/CartoDB/CartoDB-SQL-API.git && \
    cd CartoDB-SQL-API && \
    git checkout tags/$v && \
    ./configure && \
    npm install

# Create configuration
ADD ./config/CartoDB-$env.js \
    /CartoDB-SQL-API/config/environments/$env.js

# Start the service
WORKDIR /CartoDB-SQL-API
# using shell form to enable variable substituion
ENTRYPOINT node app.js $env
