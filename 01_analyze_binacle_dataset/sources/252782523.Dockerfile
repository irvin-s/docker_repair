FROM centos:7  
COPY ./install.sh /tmp/install.sh  
  
RUN sh -xe /tmp/install.sh  
  
EXPOSE 80 443  
CMD [ "/usr/sbin/httpd", "-DFOREGROUND" ]  

