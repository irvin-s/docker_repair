FROM alpine  
  
MAINTAINER Fabrizio Torelli <fabrizio.torelli@wipro.com>  
  
RUN set -xe \  
&& apk update \  
&& apk upgrade \  
&& apk add nfs-utils curl bash \  
&& rm -rf /var/cache/apk/*  
  
ADD exports /etc/exports  
  
EXPOSE 111/udp 2049/tcp  
  
COPY entrypoint.sh /entrypoint.sh  
  
RUN chmod 777 /entrypoint.sh  
  
CMD ["/entrypoint.sh"]  

