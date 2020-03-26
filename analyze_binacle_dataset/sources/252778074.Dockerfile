# Caddy Dockerfile  
# VERSION 0.9  
#  
# Pull Alpine Linux stable base image  
FROM appelgriebsch/alpine:3.6  
MAINTAINER Andreas Gerlach <info@appelgriebsch.com>  
LABEL AUTHOR="Andreas Gerlach <info@appelgriebsch.com>"  
LABEL NAME="caddy"  
LABEL VERSION="0.9"  
# the directory to place the site files  
ENV CADDY_SITEDIR /data/caddy  
  
# the network interface to bind to  
ENV HOST 127.0.0.1  
  
# the port to listen to  
ENV PORT  8080  
  
USER root  
COPY caddy.sh /tmp/  
RUN \  
mkdir -p $CADDY_SITEDIR/site && \  
chown -R nobody:nobody $CADDY_SITEDIR && \  
chmod 755 /tmp/caddy.sh  
  
ONBUILD COPY Caddyfile $CADDY_SITEDIR/  
  
# Define Volume  
VOLUME $CADDY_SITEDIR/site  
  
# Define working directory.  
WORKDIR $CADDY_SITEDIR/site  
  
# Expose ports.  
EXPOSE $PORT  
# run service  
USER nobody  
ENTRYPOINT ["/tmp/start_instance.sh", "/tmp/caddy.sh"]  

