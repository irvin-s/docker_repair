# docker-version 1.11.2  
FROM alpine:edge  
MAINTAINER Danny Al-Gaaf "danny.al-gaaf@bisect.de"  
RUN apk add --no-cache --update \  
sudo \  
bash \  
ca-certificates \  
znc \  
znc-dev \  
znc-doc \  
znc-extra \  
znc-modpython \  
znc-modperl \  
&& rm -rf /var/cache/apk/*  
  
ADD docker-entrypoint.sh /entrypoint.sh  
ADD znc.conf.default /znc.conf.default  
RUN chmod 644 /znc.conf.default  
  
VOLUME /znc-data  
  
EXPOSE 6667  
ENTRYPOINT ["/entrypoint.sh"]  
CMD [""]  

