FROM ubuntu:precise  
  
COPY config/install.sh /root/  
RUN /bin/sh root/install.sh  
COPY run /usr/local/bin/run  
RUN chmod +x /usr/local/bin/run  
RUN a2enmod rewrite  
RUN a2enmod expires  
RUN a2enmod deflate  
ADD fonts.tgz /usr/share/  
  
# Declare ports to expose  
EXPOSE 80  
CMD ["/usr/local/bin/run"]  

