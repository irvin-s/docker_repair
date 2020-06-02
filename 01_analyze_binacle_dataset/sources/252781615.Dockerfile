FROM ubuntu:14.04.2  
MAINTAINER Brice Argenson <brice@clevertoday.com>  
  
RUN apt-get update -y && \  
apt-get install -y varnish libvarnish-dev  
  
ENV VCL_CONFIG /etc/varnish/default.vcl  
ENV CACHE_SIZE 64m  
ENV VARNISHD_PARAMS -p default_ttl=3600 -p default_grace=3600  
COPY ./docker-entrypoint.sh /  
  
EXPOSE 6081  
EXPOSE 6082  
ENTRYPOINT [ "/docker-entrypoint.sh" ]  
CMD [ "varnish" ]

