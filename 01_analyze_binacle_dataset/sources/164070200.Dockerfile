FROM node:8 as frontend-builder
# build frontend
RUN npm install -g ember-cli

ADD ./webapp/ /frontend/
RUN cd /frontend/ && yarn install
RUN cd /frontend/ && node_modules/.bin/ember build --environment production

FROM ekidd/rust-musl-builder:stable as rust-builder
ADD ./api-server /api-server
RUN sudo chown -R rust:rust /api-server
RUN cd /api-server && rm -rf target && cargo test --release && cargo build --release

FROM ubuntu:16.04

env PYTHON_VERSION 3.6
env PYTHON_EXECUTABLE python$PYTHON_VERSION

env LC_ALL C.UTF-8
env LANG C.UTF-8

RUN apt-get update
RUN apt-get -y install build-essential software-properties-common libpq-dev nginx curl redis-server gcc sudo libsasl2-dev libldap2-dev wget git


# nginx
RUN add-apt-repository ppa:chris-lea/nginx-devel
RUN apt-get update
RUN apt-get -y install nginx

RUN rm -rf /etc/nginx/conf.d/* /etc/nginx/sites-enabled/*

RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update
RUN apt-get install -y $PYTHON_EXECUTABLE $PYTHON_EXECUTABLE-dev

RUN wget https://bootstrap.pypa.io/get-pip.py -O /tmp/get-pip.py
RUN $PYTHON_EXECUTABLE /tmp/get-pip.py
RUN $PYTHON_EXECUTABLE -m pip install virtualenv


# dockerize
ENV DOCKERIZE_VERSION v0.3.0
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

RUN pip install pipenv

VOLUME /conf
VOLUME /uploads

ADD ./manage.py /src/
ADD ./Pipfile /src
ADD ./Pipfile.lock /src
ADD ./etc /src/etc
ADD ./_lib /src/_lib
ADD ./flask_app /src/flask_app
ADD ./migrations /src/migrations

RUN cd /src && pipenv install -d

COPY --from=frontend-builder /frontend/dist /src/webapp/dist
COPY --from=rust-builder /api-server/target/x86_64-unknown-linux-musl/release/api-server /api-server

EXPOSE 80 443

WORKDIR /src
