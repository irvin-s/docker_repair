FROM ubuntu:bionic

ENV METEOR_VERSION 1.8.0.1

RUN apt-get update -q -q && \
 apt-get --yes --force-yes install curl python build-essential git && \
 export METEOR_ALLOW_SUPERUSER=true && \
 curl https://install.meteor.com/?release=${METEOR_VERSION} | sed s/--progress-bar/-sL/g | sh && \
 adduser --system --group meteor --home / && \
 export "NODE=$(find /root/.meteor/ -path '*bin/node' | grep '/root/.meteor/packages/meteor-tool/' | sort | head -n 1)" && \
 ln -sf ${NODE} /usr/local/bin/node && \
 ln -sf "$(dirname "$NODE")/npm" /usr/local/bin/npm
