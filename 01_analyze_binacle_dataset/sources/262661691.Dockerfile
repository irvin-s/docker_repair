FROM ubuntu:16.04

RUN apt-get update

RUN apt-get install -y make gcc net-tools build-essential libtool libpcre3 libpcre3-dev zlib1g-dev openssl

MAINTAINER kingdz

ADD soft /usr/local/src/

WORKDIR /usr/local/src/

RUN tar -zxf libfastcommon-1.0.7.tar.gz && \
	cd libfastcommon-1.0.7 && \
	./make.sh && \
	./make.sh install && \
	cp /usr/lib64/libfastcommon.so /usr/lib && \
	rm -f ../libfastcommon-1.0.7.tar.gz && \

	cd /usr/local/src/ && \
	tar -zxf fastdfs-5.05.tar.gz && \
	cd fastdfs-5.05 && \
	./make.sh && \
	./make.sh install && \
	rm -f ../fastdfs-5.05.tar.gz && \
	cd .. && \

	rm -rf /etc/fdfs/* && \
	mv /usr/local/src/tracker.conf /etc/fdfs/ && \
	mv /usr/local/src/storage.conf /etc/fdfs/ && \
	mv /usr/local/src/client.conf /etc/fdfs/ && \
	mv -f /usr/local/src/fdfs_trackerd /etc/init.d/fdfs_trackerd && \
	mv -f /usr/local/src/fdfs_storaged /etc/init.d/fdfs_storaged && \
	mkdir -p /fastdfs/tracker && \
	mkdir -p /fastdfs/storage && \
	mkdir -p /fastdfs/client && \

	tar -zxf fastdfs-nginx-module_v1.16.tar.gz && \
	rm fastdfs-nginx-module_v1.16.tar.gz && \
	mv -f config fastdfs-nginx-module/src/ && \
	
	tar -zxf nginx-1.10.3.tar.gz && \
	rm nginx-1.10.3.tar.gz && \
	cd nginx-1.10.3 && \
	./configure --add-module=/usr/local/src/fastdfs-nginx-module/src && \
	make && \
	make install && \

	mv -f /usr/local/src/mod_fastdfs.conf /etc/fdfs/ && \
	cp /usr/local/src/fastdfs-5.05/conf/http.conf /etc/fdfs/  && \
	cp /usr/local/src/fastdfs-5.05/conf/mime.types /etc/fdfs/ && \
	mkdir -p /fastdfs/storage/data/M00 && \
	ln -s /fastdfs/storage/data/ /fastdfs/storage/data/M00 && \
	mv /usr/local/src/nginx.conf /usr/local/nginx/conf/ && \
	cp /usr/lib64/* /usr/lib/ && \
	chmod +x /usr/local/src/start.sh

EXPOSE 8888

#/etc/init.d/fdfs_trackerd start
#/etc/init.d/fdfs_storaged start
#/usr/local/nginx/sbin/nginx
#172.17.0.2