FROM node:6-stretch as base

ARG COMPUTE_WEBAPP_VER

COPY . /esgf-compute-wps

WORKDIR /esgf-compute-wps/webapp

FROM base as builder

RUN yarn && \
      ./node_modules/.bin/webpack --config config/webpack.prod.js

FROM base as dev

RUN yarn && \
      ./node_modules/.bin/webpack --config config/webpack.dev.js && \
      yarn add -D http-server

COPY docker/webapp/entrypoint.sh .

ENTRYPOINT ["./entrypoint.sh"]

FROM nginx:1.15 as prod

ENV COMPUTE_WEBAPP_VER ${COMPUTE_WEBAPP_VER}

WORKDIR /usr/share/nginx/html

COPY docker/webapp/default.conf /etc/nginx/conf.d/default.conf

COPY --from=builder /assets static/

RUN mv static/js/index.html .
