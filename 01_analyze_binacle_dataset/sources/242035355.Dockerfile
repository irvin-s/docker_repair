FROM node:8-alpine
WORKDIR /app

# Instal base packages
RUN set -ex && \
    apk update && \
    apk add ca-certificates && \
    update-ca-certificates && \
    apk add --no-cache \
    openssl \
    curl \
    git \
    build-base \
    libc6-compat \
    openssh-client

# Install additional app packages
RUN apk add --no-cache \
    sox \
    opus-tools # Used to decode Telegram Audio notes

# Install imagemagick
RUN apk add --no-cache imagemagick graphicsmagick

# Cleanup
RUN rm -rf /var/cache/apk/*

# Install node modules
COPY package.json yarn.lock ./
RUN yarn install

# Copy my code
COPY . .

ENTRYPOINT [ "npm", "run", "start" ]
EXPOSE 80
