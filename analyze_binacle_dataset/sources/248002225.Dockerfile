FROM ubuntu:trusty

MAINTAINER xzdbd <xzdbd@sina.com>

# install dependency
RUN set -ex &&\
	apt-get update && \
	apt-get install -y build-essential libpcre3 libpcre3-dev zlib1g-dev unzip git wget

# get OpenSSL, Cloudflare Patch and nginx-ct
RUN git clone https://github.com/cloudflare/sslconfig && \
	wget -O openssl.zip -c https://github.com/openssl/openssl/archive/OpenSSL_1_0_2h.zip && \
	unzip openssl.zip && \
	mv openssl-OpenSSL_1_0_2h/ openssl && \
	cd openssl && \
	patch -p1 < ../sslconfig/patches/openssl__chacha20_poly1305_draft_and_rfc_ossl102g.patch && \ 
	cd ../ && \
	wget -O nginx-ct.zip -c https://github.com/grahamedgecombe/nginx-ct/archive/v1.2.0.zip && \
	unzip nginx-ct.zip

# insatll nginx with openssl module, enable ipv6 and http_gzip_static
RUN wget -c https://nginx.org/download/nginx-1.11.2.tar.gz && \
	tar zxf nginx-1.11.2.tar.gz && \
	cd nginx-1.11.2/ && \
	./configure --add-module=../nginx-ct-1.2.0 --with-openssl=../openssl --with-http_v2_module --with-http_ssl_module --with-ipv6 --with-http_gzip_static_module && \
	make && \
	make install

RUN rm -rf /nginx-1.11.2 && \
	rm -rf /nginx-ct-1.2.0 && \
	rm -rf /nginx-1.11.2.tar.gz && \
	rm -rf /nginx-ct.zip && \
	rm -rf /openssl && \
	rm -rf /openssl.zip && \
	rm -rf /sslconfig

CMD /usr/local/nginx/sbin/nginx -g 'daemon off;'

	