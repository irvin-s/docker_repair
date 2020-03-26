FROM scratch  
  
MAINTAINER sekhmet <sekhmet@debitux.com>  
  
COPY rootfs /  
  
RUN chmod 1777 /tmp  
  
CMD ["/bin/bash"]  
  

