FROM node:9.11.1-alpine

# Install microdocs-core
ADD ./microdocs-core/dist/package.json ./microdocs-core/dist/.npmrc /app/@maxxton/microdocs-core/dist/
WORKDIR /app/@maxxton/microdocs-core/dist
RUN npm link

# Install microdocs-ui
WORKDIR /app/@maxxton/microdocs-ui
ADD ./microdocs/microdocs-ui/package.json ./microdocs/microdocs-ui/.npmrc ./
RUN rm -rf /app/@maxxton/microdocs-core/dist/node_modules && npm link @maxxton/microdocs-core
RUN npm install

# Build microdocs-ui
ADD ./microdocs-core/dist /app/@maxxton/microdocs-core/dist
ADD ./microdocs/microdocs-ui/angular-cli.json ./
CMD rm -rf ./dist/* && ./node_modules/.bin/ng build --watch
