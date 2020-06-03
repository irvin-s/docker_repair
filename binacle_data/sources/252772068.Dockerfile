FROM augustash/alpine-phpfpm:1.0.2  
# environment  
ENV DEBUG false  
ENV PHP_MEMORY_LIMIT 2G  
ENV MAGENTO_PATH /src  
ENV MAGENTO_CODEBASE cc  
ENV MAGENTO_USE_SAMPLE_DATA false  
ENV MAGENTO_INSTALL_DB false  
  
# packages & configure  
RUN apk-install git mysql-client nodejs sudo && \  
/usr/bin/npm install -g gulp grunt && \  
mkdir -p /var/log/cron && \  
apk-cleanup  
  
# copy root filesystem  
COPY rootfs /  
RUN chmod +x /usr/local/bin/*  
  
# run s6 supervisor  
ENTRYPOINT ["/init"]  

