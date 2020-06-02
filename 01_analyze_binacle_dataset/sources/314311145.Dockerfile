FROM node:8.9-alpine
LABEL org.label-schema.vcs-url="https://github.com/david-kroell/ytdl"

RUN apk update && \
    apk add ffmpeg && \
    rm -rf /var/cache/apk/*

ENV NODE_ENV production
WORKDIR /usr/src/app
COPY ["package.json", "package-lock.json*", "npm-shrinkwrap.json*", "./"]
RUN npm install --production && mv node_modules ../
COPY . .
EXPOSE 3000
ENTRYPOINT [ "/usr/bin/env", "node", "/usr/src/app/ytdl.js" ]
