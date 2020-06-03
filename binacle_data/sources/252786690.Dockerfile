FROM alpine:3.7  
ENV VARNISH_VERSION 5.2  
RUN apk add --update --no-cache \  
bash \  
varnish \  
&& rm -rf /var/cache/apk/*  
  
COPY default.vcl /opt/default.vcl  
COPY startup.sh /opt/startup.sh  
  
ENV VARNISH_PORT 80  
ENV VARNISH_ADMIN_PORT 6082  
ENV VARNISH_BACKEND_HOST web  
ENV VARNISH_BACKEND_PORT 80  
ENV VARNISH_CACHE_SIZE 64M  
# See https://varnish-cache.org/docs/4.1/reference/varnishd.html  
ENV VARNISH_VARNISHD_PARAMS ''  
# See https://varnish-cache.org/docs/4.1/reference/varnishncsa.html  
ENV VARNISH_VARNISHNCSA_PARAMS ''  
EXPOSE 80  
EXPOSE 6082  
CMD ["/opt/startup.sh"]  

