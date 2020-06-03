FROM node:8.11

RUN apt-get update && \
    apt-get install -y \
      zip \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /srv

RUN cd /tmp && wget https://github.com/Opla/front/archive/master.zip && \
  unzip master.zip && \
  mv front-master /srv/app && \
  rm /tmp/master.zip

RUN cd /srv/app && yarn install

COPY ./bin/entrypoint.sh /srv/entrypoint.sh
RUN chmod u+x /srv/entrypoint.sh

ENTRYPOINT [ "/srv/entrypoint.sh" ]
