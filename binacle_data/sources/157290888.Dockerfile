FROM node:0.12.9

MAINTAINER Dustin McQuay <dmcquay@gmail.com>

COPY . /data

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -q -y \
        graphicsmagick && \
    apt-get clean autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/{apt,dpkg,cache,log} && \
    rm -rf /var/lib/apt/lists/* && \
    cd /data && \
    npm install .

EXPOSE 3000

WORKDIR /data

CMD ["node", "app.js"]
