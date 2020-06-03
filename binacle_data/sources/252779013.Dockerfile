FROM alpine:3.4  
VOLUME ["/tarfile","/volume"]  
  
ENV TAR_EXTRA_ARGUMENT="--overwrite"  
ENV TAR_VERBOSE_FLAG=true  
  
COPY entrypoint.sh /  
ENTRYPOINT ["/entrypoint.sh"]  

