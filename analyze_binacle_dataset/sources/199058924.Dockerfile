FROM node:9.11.1-alpine

EXPOSE 3000
WORKDIR /microdocs/microdocs-server/dist
CMD ["node", "index.js"]

ADD microdocs-server/config.yml /microdocs/microdocs-server/config.yml
ADD microdocs-server/dist/ /microdocs/microdocs-server/dist/
ADD microdocs-ui/dist/ /microdocs/microdocs-ui/dist/
ARG CLI_VERSION
RUN echo @maxxton:registry=https://nexus-dev.maxxton.com/repository/npm-group/ > ~/.npmrc && \
    npm install -g @maxxton/microdocs-cli@$CLI_VERSION