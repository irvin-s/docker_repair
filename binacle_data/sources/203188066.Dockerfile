FROM datascienceschool/ubuntu:latest
MAINTAINER "Joel Kim" admin@datascienceschool.net

################################################################################
# Redis
################################################################################

USER root
COPY ./6379-docker.conf /etc/redis/6379.conf
ENV REDIS_PORT=6379
ENV REDIS_CONFIG_FILE=/etc/redis/6379.conf
ENV REDIS_LOG_FILE=/var/log/redis_6379.log
ENV REDIS_DATA_DIR=/var/lib/redis/6379
ENV REDIS_EXECUTABLE='command -v redis-server'
RUN \
mkdir -p /etc/redis && \
mkdir -p /var/log/redis && \
mkdir -p /var/lib/redis/6379 && \
mkdir -p ~/temp && \
cd ~/temp && \
wget http://download.redis.io/redis-stable.tar.gz && \
tar xvzf redis-stable.tar.gz && \
cd redis-stable && \
make && \
make install && \
./utils/install_server.sh && \
rm -rf ~/temp

EXPOSE 6379

################################################################################
# MongoDb
################################################################################

USER root
RUN \
mkdir -p /data/db && \
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6 && \
echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list && \
DEBIAN_FRONTEND=noninteractive apt update -y -q && \
DEBIAN_FRONTEND=noninteractive apt install -y -q mongodb-org

EXPOSE 27017 28017

################################################################################
# Docker Entrypoint
################################################################################

ENTRYPOINT ["/bin/bash"]
