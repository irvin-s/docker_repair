FROM node:7.9-alpine

RUN apk add -U --no-cache \
      bash \
      git \
      curl \
      && \
    mkdir -p /app/api-graphql

WORKDIR /app/api-graphql

# Copy the package.json as well and install all packages.
# This is a separate step so the dependencies
# will be cached unless changes the file are made.
COPY package.json yarn.lock ./
RUN yarn install

COPY . ./

CMD ["yarn"]

