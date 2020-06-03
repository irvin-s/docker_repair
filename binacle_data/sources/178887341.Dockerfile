FROM node:11-alpine

ENV PROJECT_PATH        /AMHub

# system dependecies
RUN apk add --no-cache git

# create non-root user
RUN addgroup -S app && adduser -S -G app app

# create workspace
WORKDIR ${PROJECT_PATH}
# get project
ADD . .

# change permission
RUN chown -R app:app .
# change user
USER app

# project dependecies
RUN yarn install
# compile
RUN yarn build
# run
CMD yarn start

# network
EXPOSE 8080 2375

# change user
USER root