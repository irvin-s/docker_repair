FROM aesopagency/base:ubuntu-14.04  
MAINTAINER Aesop Agency <technical@aesopagency.com>  
  
WORKDIR /tmp  
  
COPY config/replace-var.sh replace-var.sh  
RUN chmod 755 replace-var.sh  
  
WORKDIR /data  
  
ENTRYPOINT ["/tmp/replace-var.sh"]  
CMD []

