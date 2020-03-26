FROM gliderlabs/alpine:3.2  
MAINTAINER Jean Mertz <jean@blendle.com>  
  
WORKDIR /home  
  
CMD ["/bin/sh"]  
  
COPY repositories /etc/apk/repositories  
  
COPY bin/ /usr/local/bin/  
  
RUN bnl-apk-install-download-deps \  
&& bnl-download-and-verify BF357DD4 \  
https://github.com/tianon/gosu/releases/download/1.4/gosu-amd64.asc \  
&& mv gosu-amd64 /usr/local/bin/gosu \  
&& chmod +x /usr/local/bin/gosu \  
&& apk del download-deps  

