FROM node:alpine

# Install yarn
RUN echo -e 'http://dl-cdn.alpinelinux.org/alpine/edge/main\nhttp://dl-cdn.alpinelinux.org/alpine/edge/community\nhttp://dl-cdn.alpinelinux.org/alpine/edge/testing' > /etc/apk/repositories \
    && apk add --no-cache yarn

# Create app directory
RUN mkdir -p /home/app

# Bundle app soure
COPY . /home/app

# From now on we work in /home/app
WORKDIR /home/app
RUN  yarn

EXPOSE 8080
