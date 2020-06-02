#BUILD_PUSH=hub,quay
FROM bigm/base-deb-tools

# https://github.com/docker-library/mongo
# http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 \
  && echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.0.list \
  && /xt/tools/_apt_install adduser ca-certificates curl numactl \
    mongodb-org mongodb-org-server mongodb-org-shell mongodb-org-mongos mongodb-org-tools

## grab gosu for easy step-down from root
#RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
#RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture)" \
#	&& curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture).asc" \
#	&& gpg --verify /usr/local/bin/gosu.asc \
#	&& rm /usr/local/bin/gosu.asc \
#	&& chmod +x /usr/local/bin/gosu

# startup
COPY startup/* /prj/startup/
ADD supervisor/* /etc/supervisord.d/
# configuration
ENV MONGODB_OPTS "--storageEngine=wiredTiger"

## expose ports
EXPOSE 27017 28017
## where data are stored
VOLUME /prj/data/db
