
FROM centos:centos7

MAINTAINER The CentOS Redis Project <qiaiduo@163.com> 

ENV REDIS_VERSION=4.0.2
ENV REDIS_DOWNLOAD_URL=http://download.redis.io/releases/redis-${REDIS_VERSION}.tar.gz \
        REDIS_DOWNLOAD_SHA1=26c0fc282369121b4e278523fce122910b65fbbf
 
RUN \
        yum -y install wget -y && \
	yum -y install gcc automake autoconf libtool make -y && \
	yum install gcc gcc-c++ -y && \
        mkdir /tmp/redis && \
        cd /tmp/redis && \
        wget ${REDIS_DOWNLOAD_URL} && \
        tar xvf redis-${REDIS_VERSION}.tar.gz && \
        cd redis-${REDIS_VERSION} && \
        make && \
        make install && \
        mkdir -p /usr/local/redis/{bin,etc,var} && \
        cp -af src/{redis-benchmark,redis-check-aof,redis-check-rdb,redis-cli,redis-sentinel,redis-server} /usr/local/redis/bin/ && \
        cp -a redis.conf /usr/local/redis/etc/ && \
        echo "export PATH=/usr/local/redis/bin:\$PATH" > /etc/profile.d/redis.sh && \
        source /etc/profile.d/redis.sh && \
        useradd -r -s /sbin/nologin -c "Redis Server" -d /data -m -k no redis && \
        yum clean all && \
        rm -rf /tmp/redis
 
COPY entrypoint.sh /usr/local/redis/bin/entrypoint.sh
RUN chmod +x /usr/local/redis/bin/entrypoint.sh
 
VOLUME ["/data"]
WORKDIR /data
 
EXPOSE 6379/tcp
 
ENTRYPOINT ["/usr/local/redis/bin/entrypoint.sh"]
 
CMD ["redis-server"]


