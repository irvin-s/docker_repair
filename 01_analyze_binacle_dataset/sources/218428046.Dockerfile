FROM node:alpine

# Create app directory
RUN mkdir -p /code/honeycomb-assets
WORKDIR /code/honeycomb-assets

# Set environment variable
ENV NODE_ENV production

# Install app dependencies
COPY package.json /code/honeycomb-assets/
RUN apk add --no-cache --virtual .app-deps python make g++ \
  && yarn --pure-lockfile \
  && yarn cache clean \
  && apk del .app-deps

# Bundle app source
COPY . /code/honeycomb-assets

# Port
EXPOSE 3001

# Start
CMD [ "yarn", "start" ]
