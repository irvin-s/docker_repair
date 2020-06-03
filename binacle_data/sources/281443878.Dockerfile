# ---- Base Node ----
FROM node:carbon AS base
# Create app directory
WORKDIR /app

# ---- Dependencies ----
FROM base AS dependencies
COPY package*.json ./
COPY yarn.lock ./
COPY preact.config.js ./
RUN yarn install

# ---- Copy Files/Build ----
FROM dependencies AS build
WORKDIR /app
COPY src /app/src
RUN yarn build
RUN yarn install --modules-folder /app/deps --production=true

# --- Release with Alpine ----
FROM node:8.9-alpine AS release
WORKDIR /app

# install new ffmpeg version using edge repositories
RUN sed -i -e 's/v[[:digit:]]\.[[:digit:]]/edge/g' /etc/apk/repositories
RUN apk del --purge alpine-baselayout; apk --update add alpine-baselayout busybox; apk upgrade --purge
RUN apk --update add ffmpeg

COPY --from=build /app/build ./build
COPY --from=build /app/deps ./node_modules

VOLUME /data /incoming

CMD ["node", "build/transcode.js", "/incoming", "/data"]
