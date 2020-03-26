FROM ubuntu:16.04

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r mongodb && useradd -r -g mongodb mongodb

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6 && \
    echo "deb [ arch=amd64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list && \
    apt-get -q update && \
	apt-get -y -q install --no-install-recommends \
		numactl && \
	apt-get install -y -q mongodb-org && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/lib/mongodb && \
	mv /etc/mongod.conf /etc/mongod.conf.orig && \
	mkdir -p /data/db /opt/mongo && chown -R mongodb:mongodb /data/db /opt/mongo

# mongo root user (change me!)
ENV MONGO_ROOT_USER root
ENV MONGO_ROOT_PASSWORD root123

# mongo app user + database (change me!)
ENV MONGO_APP_USER tensor
ENV MONGO_APP_PASSWORD tensor
ENV MONGO_APP_DATABASE tensordb

COPY run.sh /run.sh
RUN chmod +x /run.sh

VOLUME /data/db

EXPOSE 27017

# default storage engine wiredTiger
CMD ["/run.sh"]
