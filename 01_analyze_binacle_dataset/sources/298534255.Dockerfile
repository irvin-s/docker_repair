FROM node:6
RUN mkdir -p /data/www
ADD tripapi/ /data/www
WORKDIR /data/www
EXPOSE 8099