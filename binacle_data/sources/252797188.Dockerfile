# Latest Ubuntu LTS  
FROM alpine  
  
MAINTAINER Erik Osterman "e@osterman.com"  
# System  
ENV VARNISH_BACKEND_HOST localhost  
ENV VARNISH_BACKEND_PORT 80  
ENV VARNISH_THREAD_POOLS 25  
ENV VARNISH_THREAD_POOL_MIN 100  
ENV VARNISH_CLI_TIMEOUT 86400  
ENV VARNISH_STORAGE 1G  
  
ENV VARNISH_SECRET=  
  
RUN set -ex \  
&& apk update \  
&& apk add \  
bash \  
varnish  
  
ADD rootfs /  
  
EXPOSE 80  
EXPOSE 6082  
CMD /init.sh  
  

