FROM ubuntu:15.04
MAINTAINER datawarehouse <aus-eng-data-warehouse@rmn.com>

RUN apt-get update
RUN apt-get install -y nginx vim curl

ADD src/nginx/nginx.conf /src/nginx/nginx.conf

RUN mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.backup
RUN ln -s /src/nginx/nginx.conf /etc/nginx/nginx.conf

# forward request and error logs to docker log collector (http://stackoverflow.com/a/28464990/2009581)
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 8080

CMD ["nginx"]
