FROM alpine:latest  
MAINTAINER binking338 <binking338@163.com>  
  
ENV RPC_LISTEN_PORT 6800  
ENV BT_LISTEN_PORT 16881  
ENV DHT_LISTEN_PORT 16891  
EXPOSE $RPC_LISTEN_PORT $BT_LISTEN_PORT $DHT_LISTEN_PORT  
  
VOLUME ["/downloads", "/etc/aria2"]  
  
ADD shell/run.sh /usr/local/bin  
ADD aria2.conf /  
  
RUN apk --update --upgrade add aria2 && rm -rf /var/cache/apk/* && \  
chmod a+x /usr/local/bin/run.sh  
  
ENTRYPOINT run.sh

