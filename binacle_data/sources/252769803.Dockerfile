FROM alpine:3.4  
MAINTAINER Arnaud Piroelle "piroelle.arnaud@gmail.com"  
RUN apk add --no-cache bash transmission-daemon  
  
COPY asset/settings.json /tmp/settings.json  
COPY entrypoint.sh /opt/entrypoint.sh  
  
EXPOSE 9091  
ENTRYPOINT ["/opt/entrypoint.sh"]  
CMD ["transmission-daemon", "-f", "--config-dir", "/transmission/config"]  

