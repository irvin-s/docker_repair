FROM node:9-alpine

# Dependencies
RUN apk --no-cache --update add git python make g++

# Install middleware
RUN mkdir -p /app
COPY ./package.json /app/package.json
# COPY ./package-lock.json /app/package-lock.json
WORKDIR /app
RUN npm install && apk del git python make g++

COPY . /app

# Runtime
CMD ["npm", "start"]
