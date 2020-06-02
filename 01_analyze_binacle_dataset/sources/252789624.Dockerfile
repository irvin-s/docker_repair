FROM ubuntu  
COPY prepare.ubuntu.sh /tmp/prepare.ubuntu.sh  
COPY gnupg.tar.gz /var/gnupg.tar.gz  
RUN sh /tmp/prepare.ubuntu.sh  
EXPOSE 443  
EXPOSE 9390  
VOLUME ["/usr/local/var/lib/openvas/", "/usr/local/var/log/openvas/"]  
CMD ["entry-point.sh"]  

