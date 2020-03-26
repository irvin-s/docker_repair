FROM unocha/alpine-base-nodejs:3.6-201708-01

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

ENV NODE_APP_DIR=/srv/www \
    PORT=3000

COPY run_node package.json server.js /tmp/

WORKDIR "${NODE_APP_DIR}"

RUN mkdir -p /srv/www /srv/example /etc/services.d/node /root && \
    mv /tmp/run_node /etc/services.d/node/run && \
    mv /tmp/server.js /srv/example/ && \
    mv /tmp/package.json /srv/example/

EXPOSE ${PORT}

# mainly used to serve stuff so it makes sense to use ${NODE_APP_DIR} as WORKDIR
# but it doesnt make sense to make a volume out of it, unless you are doing it at runtime.
# VOLUME ["${NODE_APP_DIR}"]
