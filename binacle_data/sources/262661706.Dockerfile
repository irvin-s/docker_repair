FROM ubuntu:16.10

RUN apt-get update && apt-get install -y make gcc net-tools build-essential libtool ruby

MAINTAINER kingdz

ADD soft /usr/local/src/

WORKDIR /usr/local/src/

RUN tar -zxf redis-3.0.0.tar.gz && \
	rm -f redis-3.0.0.tar.gz && \
	gem install redis && \
	cd redis-3.0.0 && \
	make && \
	make install && \

#搭建集群的准备工作
	cp src/redis-trib.rb /usr/local/bin/ && \
	cd .. && \
	mkdir redis_cluster && \
	cd redis_cluster && \
	mkdir 7001 && \
	mkdir 7002 && \
	mkdir 7003 && \
	cd /usr/local/src/ && \
	mv redis-7001.conf redis_cluster/7001/ && \
	mv redis-7002.conf redis_cluster/7002/ && \
	mv redis-7003.conf redis_cluster/7003/ && \
	chmod u+x three-single-cluster.sh
