FROM codeserver/runtime-image-base  
MAINTAINER Neil Ellis hello@neilellis.me  
COPY bin/update.sh /usr/local/bin/update.sh  
COPY bin/app.sh /etc/service/app/run  
COPY info/* /usr/local/info/  
COPY bin/* /usr/local/bin/  
COPY etc/* /usr/local/etc/  
COPY lib/* /usr/local/lib/  
  
RUN chmod 755 /usr/local/bin/* /etc/service/app/run && \  
chown -R app:insecure /usr/local/log  

