FROM node:6.10.2-slim

# Install Redis
RUN apt-get update && apt-get -y install redis-server --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Create app directory
RUN mkdir -p /usr/src/humix
WORKDIR /usr/src/humix

# Bundle app source
COPY . /usr/src/humix
RUN npm_config_loglevel=silent npm install

RUN mkdir /data && chown redis:redis /data
VOLUME /data

EXPOSE 3000 
CMD [ "./bin/start.sh" ]
