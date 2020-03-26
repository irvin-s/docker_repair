# MongoDB (gewo/mongodb)
FROM gewo/mongodb-base
MAINTAINER Gebhard Wöstemeyer <g.woestemeyer@gmail.com>

ENV MONGODB_VERSION 3.0.1

RUN echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.0.list

RUN \
  apt-get update && \
  apt-get install -y \
  mongodb-org=$MONGODB_VERSION \
  mongodb-org-server=$MONGODB_VERSION \
  mongodb-org-shell=$MONGODB_VERSION \
  mongodb-org-mongos=$MONGODB_VERSION \
  mongodb-org-tools=$MONGODB_VERSION && \
  apt-get clean

CMD ["start_mongodb"]
