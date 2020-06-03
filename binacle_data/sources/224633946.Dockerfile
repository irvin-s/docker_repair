FROM offlineregistry.dataman-inc.com:5000/library/centos7-base:latest
MAINTAINER yhchen <yhchen@dataman-inc.com>

RUN yum -y install wget && \
yum -y install make gcc && \
yum clean all && \
mkdir -p /data && \
cd /data/ && \
wget http://download.redis.io/releases/redis-3.0.7.tar.gz && \
tar -xzf redis-3.0.7.tar.gz && \
cd redis-3.0.7/ && \
make && \
make install && \
mkdir -p /data/store/redis
COPY etc/ /etc/

EXPOSE 6379
CMD ["/bin/bash", "-c", "/etc/init.d/redis start"]
