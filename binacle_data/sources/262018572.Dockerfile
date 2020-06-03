FROM node:9.8.0-slim AS js-env
RUN mkdir -p /usr/src/node_app/static
WORKDIR /usr/src/node_app
COPY *.json ./
RUN npm install
COPY *.js ./
COPY js /usr/src/node_app/js
RUN npm run build-production

FROM python:3.5.5-slim as py-env

ENV TINI_VERSION v0.17.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

RUN apt-get update && apt-get install -y \
        gcc \
        gettext \
        mysql-client default-libmysqlclient-dev \
        libxml2-dev libxslt1-dev \
    --no-install-recommends && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app
COPY ./requirements.txt /usr/src/app/
RUN pip install --no-cache-dir -r requirements.txt


COPY . /usr/src/app
RUN mkdir -p /usr/src/app/static/bundles
RUN mkdir -p /usr/src/app/static/dist
COPY --from=js-env /usr/src/node_app/static/dist/* /usr/src/app/static/dist/
COPY --from=js-env /usr/src/node_app/webpack*.json /usr/src/app/
ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_HOST
ARG MYSQL_DATABASE
ARG MYSQL_PORT
ENV MYSQL_USER="$MYSQL_USER"
ENV MYSQL_PASSWORD="$MYSQL_PASSWORD"
ENV MYSQL_HOST="$MYSQL_HOST"
ENV MYSQL_DATABASE="$MYSQL_DATABASE"
ENV MYSQL_PORT="$MYSQL_PORT"
ENTRYPOINT ["/tini", "-g", "--"]
CMD ["./run.sh"]
