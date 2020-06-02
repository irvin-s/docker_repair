FROM mongo:latest

MAINTAINER yesterday679 <yesterday679@gmail.com>

#COPY mongo.conf /usr/local/etc/mongo/mongo.conf

VOLUME /data/db /data/configdb

CMD ["mongod"]

EXPOSE 27017