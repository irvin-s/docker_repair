FROM mysql:5.5  
  
# Set default timezone.  
RUN cp -p /usr/share/zoneinfo/Japan /etc/localtime  

