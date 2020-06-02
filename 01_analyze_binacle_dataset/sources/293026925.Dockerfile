FROM        stibbons31/alpine-s6-python3-twisted:py3.6-tx17.9
MAINTAINER  gaetan@xeberon.net

# set environment variables
ENV         PYTHONIOENCODING="UTF-8"

RUN         apk add --no-cache --update \
                    curl \
                    gcc \
                    git \
                    linux-headers \
                    make \
                    musl-dev \
                    nodejs \
                    python2 \
                    python3-dev

# Install frontend high level dependencies
RUN         apk add --no-cache --update \
                    nodejs \
                    nodejs-npm \
        &&  npm install -g npm@5

# Injecting files into containers
RUN         mkdir -p /app
WORKDIR     /app

# Keep dependencies on its own Docker FS Layer
# To avoid reinstall of all dependencies each time code changes
COPY        Pipfile* setup-pip.sh /app/
RUN         ./setup-pip.sh \
        &&  pipenv install --system --skip-lock

# installing main Python module so that PBR finds the version
# used in later 'make version' targets
COPY        . /app/
RUN         cd /app \
        &&  pip install .

# Adding rest of the application in next docker layers
COPY        frontend /app/frontend/

RUN         cd /app/frontend \
        &&  make dev \
        &&  make version \
        &&  make build \
        &&  mkdir -p /www \
        &&  cp -rf dist/* /www/ \
        &&  rm -rf /app/frontend

RUN         npm cache clear --force \
        &&  apk del \
                    nodejs \
                    nodejs-npm

# copy containers's startup files
COPY        dockerfs/ /
RUN         mkdir -p /media

USER        root
# clean up
# dopplerr is installed on the system, /www has the frontend
RUN         rm -rfv /app

RUN         apk del \
                    python3-dev \
                    make \
                    gcc \
                    curl \
                    linux-headers \
                    musl-dev \
                    nodejs  \
        &&  rm  -rf \
                /root/.cache \
                /tmp/*

# Docker configuration
EXPOSE      8086
VOLUME      /config \
            /animes \
            /movies \
            /tv
