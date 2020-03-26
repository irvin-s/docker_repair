FROM daewood/abase  
  
MAINTAINER daewood <daewood@qq.com>  
  
RUN apk --update add redis \  
&& rm -rf /var/cache/apk/*  
  
COPY rootfs/ /  
  
EXPOSE 6379  
VOLUME [ "/data"]  
WORKDIR /data  
ENTRYPOINT ["/init"]  
  

