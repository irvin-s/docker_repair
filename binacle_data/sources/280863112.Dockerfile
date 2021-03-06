# 1. Generate licenses

FROM node:11.9-alpine AS builder
WORKDIR /usr/src/alfresco
COPY package.json package.json

RUN mkdir -p ./licenses && \
  yarn licenses list > ./licenses/licenses.txt && \
  yarn licenses generate-disclaimer > ./licenses/disclaimer.txt

# 2. Generate image

FROM nginx:stable-alpine
LABEL version="1.7"
LABEL maintainer="Denys Vuika <denys.vuika@alfresco.com>"

ARG GROUPNAME=Alfresco
ARG GROUPID=1000
ARG USERNAME=aca
ARG USERID=33009

COPY ./docker/nginx.conf /etc/nginx/nginx.conf
COPY ./docker/entrypoint.sh /

WORKDIR /usr/share/nginx/html
COPY dist/app/ .
COPY --from=builder /usr/src/alfresco/licenses ./licenses

RUN addgroup -g ${GROUPID} ${GROUPNAME} && \
  adduser -S -u ${USERID} -G ${GROUPNAME} -s "/bin/bash" ${USERNAME} && \
  chown -R ${USERNAME}:${GROUPNAME} ./app.config.json && \
  chown -R ${USERNAME}:${GROUPNAME} ./index.html && \
  chown -R ${USERNAME}:${GROUPNAME} /var/cache/nginx && \
  touch /var/run/nginx.pid && \
  chown -R ${USERNAME}:${GROUPNAME} /var/run/nginx.pid && \
  chmod +x /entrypoint.sh && \
  chown -R ${USERNAME}:${GROUPNAME} /entrypoint.sh

EXPOSE 8080
USER ${USERNAME}
ENTRYPOINT [ "/entrypoint.sh" ]
