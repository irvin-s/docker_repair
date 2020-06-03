FROM node:boron-alpine

ARG NODE_ENV=production

# Make the directory where the app will be installed.
RUN mkdir -v /cachelink
WORKDIR /cachelink

# Install npm dependencies.
COPY . .
RUN export npm_config_loglevel=warn NODE_ENV=$NODE_ENV && npm install && npm prune

# Add a user to run the app under.
RUN adduser -Ds /bin/bash cachelink && chown -R cachelink:cachelink /cachelink
USER cachelink

EXPOSE 3111
ENTRYPOINT ["./bin/cachelink"]
