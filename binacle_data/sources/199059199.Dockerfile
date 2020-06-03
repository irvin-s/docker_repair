FROM node:9.11.1-alpine

# Install dependencies
WORKDIR /app/@maxxton/microdocs-server
ADD ./microdocs-core/dist/package.json ./microdocs-core/dist/.npmrc ./node_modules/@maxxton/microdocs-core/
ADD ./microdocs/microdocs-server/package.json ./microdocs/microdocs-server/.npmrc ./
RUN npm install

# Build microdocs-server
ADD ./microdocs/microdocs-server/gulpfile.js ./microdocs/microdocs-server/build.js ./microdocs/microdocs-server/config.yml ./
CMD rm -rf ./dist/* && ./node_modules/.bin/gulp watch