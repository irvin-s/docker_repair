FROM jenkins  
  
# Install plugins  
COPY plugins.txt /usr/local/etc/plugins.txt  
RUN /usr/local/bin/plugins.sh /usr/local/etc/plugins.txt  

