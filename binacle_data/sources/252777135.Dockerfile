FROM progrium/busybox  
RUN opkg-install bash  
RUN mkdir -p /etc/ssl && mkdir -p /etc/ssl/certs  
ADD certs /etc/ssl/certs/  
ENV SHELL /bin/bash  
ADD cluster/cluster cluster  
RUN chmod +x cluster  
CMD "./cluster"  

