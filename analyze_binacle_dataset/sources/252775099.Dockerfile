FROM busybox:latest  
  
COPY signal.sh /  
CMD ["/signal.sh"]  

