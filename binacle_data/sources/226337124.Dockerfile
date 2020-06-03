# Build dashboard
FROM node:8-slim AS dashboard-build

WORKDIR /usr/src/app

COPY . /usr/src/app/

RUN npm install --unsafe-perm --quiet

ARG EDITION

RUN npm run build-$EDITION && \
    rm packages/dashboard-$EDITION/build/static/js/*.js.map

# Final docker image
FROM nginx:stable

RUN rm /etc/nginx/conf.d/default.conf
COPY docker/nginx.conf.template /etc/nginx/conf.d/dashboard.conf.template
COPY docker/dashboard.sh /usr/local/bin/serve-dashboard
RUN chmod +x /usr/local/bin/serve-dashboard

ARG EDITION
ARG REVISION

COPY --from=dashboard-build \
    /usr/src/app/packages/dashboard-$EDITION/build/ \
    /var/www

ENV DASHBOARD_SERVER_NAME=faunadb-dashboard \
    DASHBOARD_PORT=80 \
    DASHBOARD_PROTOCOL=http

LABEL dashboard.edition=$EDITION \
    dashboard.revision=$REVISION \
    maintainer="Fauna, Inc. <support@fauna.com>"

CMD ["serve-dashboard"]
