FROM node:alpine

# Create app directory
RUN mkdir -p /code/honeycomb-layout
WORKDIR /code/honeycomb-layout

# Set environment variable
ENV NODE_ENV production

# Install app dependencies
COPY package.json /code/honeycomb-layout/
RUN apk add --no-cache --virtual .app-deps python make g++ \
  && yarn --pure-lockfile \
  && yarn cache clean \
  && apk del .app-deps

# Bundle app source
COPY . /code/honeycomb-layout

# Port
EXPOSE 3000

# Start
CMD [ "yarn", "start" ]
