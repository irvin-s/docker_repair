FROM mhart/alpine-node:6
# FROM node:latest
MAINTAINER [Rhio Kim <rhio.kim@gmail.com>]

#copy package first to cache npm-install and speed up build
COPY server server
COPY build www

WORKDIR server
RUN npm --quiet --no-color install

EXPOSE 8082

CMD ["npm", "start"]
