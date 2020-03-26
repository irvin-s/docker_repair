FROM mongo:2.6

#COPY mongo.conf /usr/local/etc/mongo/mongo.conf

COPY mongo.sh /mongo.sh

VOLUME /data/db /data/configdb

CMD ["mongod"]

EXPOSE 27017

