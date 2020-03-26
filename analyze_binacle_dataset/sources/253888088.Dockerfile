FROM node:dubnium-alpine as builder

# I need it for my eslint rules package that I'm using from git
RUN apk update && apk add --no-cache git

ENV NODE_ENV=production

WORKDIR '/app'
COPY ./package*.json ./
RUN npm install
COPY . .
RUN npm run build

# For production I'll use simple ngnix
# @docs: https://hub.docker.com/_/nginx
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# we don't have to specidy start command
# for nginx - this command is build in in the docker image
