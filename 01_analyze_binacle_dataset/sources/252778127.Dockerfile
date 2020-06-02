FROM alpine:3.7  
MAINTAINER Jonathan Meyer <jon@gisjedi.com>  
  
LABEL name="Alpine 3.7 with gosu entrypoint" \  
vendor="Applied Information Sciences" \  
license="Apache v2.0"  
  
COPY gosu-amd64 /usr/local/bin/gosu  
RUN chmod +x /usr/local/bin/gosu  
  
# Specify any standard chown format (uid, uid:gid), default to root:root  
ENV GOSU_USER 0:0  
# Specify any space delimited directories that should be chowned to GOSU_USER  
#ENV GOSU_CHOWN /tmp  
COPY gosu-entrypoint.sh /  
  
RUN chmod +x /gosu-entrypoint.sh  
  
ENTRYPOINT ["/gosu-entrypoint.sh"]  

