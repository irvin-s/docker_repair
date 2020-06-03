FROM ambuds/storm-base  
MAINTAINER ambuds  
  
EXPOSE 6627  
EXPOSE 3772  
EXPOSE 3773  
# Set configuration script as executable  
ADD storm-nimbus.sh /opt/  
RUN chmod +x /opt/*.sh  
  
CMD /opt/storm-nimbus.sh  
  

