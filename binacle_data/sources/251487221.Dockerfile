FROM node:6

# Let the container know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# Install software requirements
RUN apt-get update && \
apt-get install -y git
RUN npm install -g node-gyp pm2

# Install/setup Python deps
RUN apt-get install -y python-pip
RUN pip install requests

WORKDIR ~

COPY blog ./blog
COPY index.js ./blog/server/config/index.js

RUN cd ./blog/server && \
    npm i && \
    cd ../client && \
    npm i && \
    npm run build

COPY docker-entrypoint.sh .
RUN chmod -R 777 docker-entrypoint.sh

EXPOSE 3000 5050

ENTRYPOINT ./docker-entrypoint.sh && /bin/bash
