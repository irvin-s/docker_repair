FROM chattaway/nslcd:latest  
  
RUN yum -y install \  
samba \  
samba-client \  
&& yum clean all  
  
RUN mkdir --parents /run/samba/ncalrpc  
  
COPY ./supervisord.conf /etc/supervisord.conf  
  
CMD ["supervisord", "--configuration", "/etc/supervisord.conf"]  
  
EXPOSE 135 139 445  
VOLUME ["/var/lib/samba", "/etc/samba"]  

