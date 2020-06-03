FROM busybox:glibc  
  
COPY run.sh /run.sh  
  
RUN chmod +x /run.sh  
  
VOLUME /data  
  
CMD ["/run.sh"]  
  

