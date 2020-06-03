FROM centos:centos6
MAINTAINER David Pelaez <david@vlipco.co>

# this will handle unarchiving! no tar xzf needed
ADD misc/ngx_openresty-1.7.2.1.tar.gz /openresty

RUN cd /openresty/ngx_openresty-1.7.2.1 && \
	yum install -y perl pcre-dev pcre-devel openssl-devel gcc && ./configure && make install && \
	ln -s /usr/local/openresty/nginx/sbin/nginx /usr/bin/nginx && yum -y remove gcc

ADD conf /nginx/conf
RUN rm -rf /openresty && mkdir /nginx/logs

EXPOSE 80

ENV NS_IP 127.0.0.1
ENV NS_PORT 53
ENV TARGET service.consul
ENV DOMAINS lvh.me,127.0.0.1.xip.io,9zlhb.xip.io
ENV KEEP_TAGS false

CMD ["/usr/bin/nginx", "-p", "/nginx/", "-c", "conf/nginx.conf"]
