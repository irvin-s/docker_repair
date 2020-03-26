# For original, see: arbourd/docker-shout

FROM node:9.6.0
MAINTAINER Odd E. Ebbesen <oddebb@gmail.com>

ENV PORT="9000"
ENV PRIVATE="true"
ENV TINI_VERSION 0.18.0
ENV TINI_GPG_KEY 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7
ENV SHOUT_DIR=/home/node/shout

VOLUME ${SHOUT_DIR}
EXPOSE ${PORT}

RUN npm install -g shout

COPY shout.sh /home/node/
RUN chown node:node /home/node/shout.sh && chmod 755 /home/node/shout.sh

ADD https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini-static /sbin/tini
ADD https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini-static.asc /tmp/tini-static.asc
RUN gpg --batch --keyserver hkp://ipv4.pool.sks-keyservers.net:80 --recv-keys $TINI_GPG_KEY
RUN gpg --batch --verify /tmp/tini-static.asc /sbin/tini
RUN chmod 755 /sbin/tini

USER node
WORKDIR ${SHOUT_DIR}

ENTRYPOINT ["tini", "-g", "--"]
CMD ["/home/node/shout.sh"]
