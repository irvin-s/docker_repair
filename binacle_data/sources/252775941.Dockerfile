FROM busybox:latest  
ADD 01-biobase.d /etc/ngchm/conf.d/01-biobase.d  
VOLUME /etc/ngchm/conf.d/01-biobase.d  
ENTRYPOINT ["/bin/true"]  

