# Extending image
FROM node:carbon-alpine

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Versions
RUN npm -v
RUN node -v

# Install app dependencies
COPY package.json /usr/src/app/
RUN npm install

# Bundle app source
COPY . /usr/src/app

# Port to listener
EXPOSE 3000

# Environment variables
ENV NODE_ENV production
ENV PORT 3000
ENV REDIS_HOST redis
ENV LOGS_FILE_NAME /var/logs/yeps.error.log
ENV MONGO_URI mongodb://mongo:27017/users
ENV JWT_TTL 86400000
ENV JWT_SECRET yeps

# Main command
CMD [ "npm", "start" ]

# Testing
# ENV DEBUG server:*
# CMD [ "npm", "t" ]
# https://github.com/deviantony/docker-elk/blob/master/docker-compose.yml
# npm run docker:build && npm run docker:run
# docker logs yeps
# npm run docker:stop
