FROM centos:7  
RUN yum install -y cups \  
&& yum clean all  
  
COPY ./custom.types /usr/share/cups/mime/custom.types  
COPY ./custom.convs /usr/share/cups/mime/custom.convs  
  
CMD ["cupsd", "-f"]  
  
EXPOSE 631  
VOLUME ["/etc/cups"]  

