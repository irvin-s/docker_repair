FROM mhart/alpine-node:latest

RUN apk add --update python build-base ffmpeg && rm -rf /var/cache/apk/*

COPY package.json /app/
WORKDIR /app

# Install deps
RUN npm install --production && \
    apk del python build-base

# Copy code after the fact, so that non-package.json changes do not invalidate cache and build in ms instead of minutes
COPY _build/ /app/

CMD ["node", "/app/index.js"]
