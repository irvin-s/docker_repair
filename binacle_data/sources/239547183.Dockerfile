FROM debian:jessie

LABEL maintainer My Name <myemail@example.com>
LABEL refreshed_at 2017-03-14

# Usually is a bad idea to run our app as admin user, so let's create a new useer
RUN groupadd --gid 1000 node \
    && useradd --uid 1000 --gid node --shell /bin/bash --create-home node \
    && mkdir -p /usr/src/app

# Do you rmemeber the diif between COPY and ADD? We can ADD a remote file using an URL
ADD https://deb.nodesource.com/setup_6.x setup_6.x

RUN bash setup_6.x \
    && apt-get install -y nodejs

# ONBUILD instructions will be triggered only when this image is usade as a base one
ONBUILD COPY package.json /usr/src/app/
ONBUILD RUN npm install && npm cache clean
ONBUILD COPY . /usr/src/app

ENV LOGS_FOLER /logs

RUN mkdir -p $LOGS_FOLER \
    && chown -hR node:node /usr/src/app

USER node
WORKDIR /usr/src/app

ENTRYPOINT ["node"]
