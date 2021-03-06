FROM node:8-alpine

ARG CACHE_SERVER_VERSION=6.2.5

LABEL org.label-schema.version=${CACHE_SERVER_VERSION}

RUN apk add --no-cache dumb-init

WORKDIR /srv/unity

COPY entrypoint.sh entrypoint.sh

RUN npm i -g unity-cache-server@${CACHE_SERVER_VERSION}

VOLUME [ "/srv/unity/cache" ]
EXPOSE 8126
ENTRYPOINT [ "/srv/unity/entrypoint.sh" ]
CMD [ "unity-cache-server" ]
