## Base image with node and entrypoint scripts ##
## =========================================== ##
FROM node:10.15.0-alpine AS base

LABEL maintainer="Lucas Clay <lclay@shipchain.io>"

ENV LANG C.UTF-8

RUN apk add --no-cache bash

RUN mkdir /app
WORKDIR /app

COPY ./compose/scripts/*.sh /
RUN chmod +x /*.sh
ENTRYPOINT ["/entrypoint.sh"]


## Image with system dependencies for building ##
## =========================================== ##
FROM base AS build

RUN apk add --no-cache \
    libc6-compat \
    # git, python, make, g++ are for installing/building several npm modules
    git \
    python \
    make \
    g++


## Image with dev-dependencies ##
## =========================== ##
FROM build AS test

COPY package.json /app/
COPY yarn.lock /app/
COPY .yarnclean /app/

RUN yarn --frozen-lockfile && yarn cache clean

COPY . /app/

RUN yarn compile

## Image only used for production building ##
## ======================================= ##
FROM build AS prod

COPY package.json /app/
COPY yarn.lock /app/
COPY .yarnclean /app/

RUN yarn --prod --frozen-lockfile && yarn cache clean

COPY . /app/

RUN yarn compile


## Image to be deployed to ECS with additional utils and no build tools ##
## ==================================================================== ##
FROM base AS deploy

# Install openssh for ECS management container
RUN apk add --no-cache \
    openssh-server-pam \
    python3 \
    jq \
    openssl \
    shadow \
    nano

RUN mkdir /var/run/sshd /etc/cron.d && touch /etc/pam.d/sshd
RUN sed -i 's/^CREATE_MAIL_SPOOL=yes/CREATE_MAIL_SPOOL=no/' /etc/default/useradd

# Keymaker for SSH auth via IAM
RUN pip3 install \
    keymaker==1.0.8 \
    awscli==1.16.95 && \
    rm -rf /root/.cache/*

# Configure public key SSH
RUN echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config
RUN echo "UsePAM yes" >> /etc/ssh/sshd_config
RUN echo "AllowAgentForwarding yes" >> /etc/ssh/sshd_config
RUN echo "PasswordAuthentication no" >> /etc/ssh/sshd_config

# Copy production node_modules without having to install packages in build
COPY --from=prod /app /app
