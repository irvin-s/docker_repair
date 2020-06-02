ARG NODE_IMAGE
ARG PYTHON_IMAGE

FROM ${NODE_IMAGE} AS node
FROM ${PYTHON_IMAGE} AS python

FROM nginx:latest
ARG TAG_NAME
COPY --from=node /usr/src/app/build/ /var/www
COPY --from=python /usr/src/app/static/ /var/www
COPY deploy/nginx-${TAG_NAME}.conf /etc/nginx/conf.d/default.conf
