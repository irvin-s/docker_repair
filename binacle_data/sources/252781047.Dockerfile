FROM alpine:latest  
  
RUN apk update  
RUN apk add cvs openssl busybox-extras  
  
ADD files/inetd.conf /etc/inetd.conf  
ADD files/run.sh /  
  
RUN chmod +x run.sh  
  
RUN echo "cvspserver 2401/tcp" >> /etc/services  
  
RUN mkdir /var/cvsroot  
  
VOLUME ["/var/cvsroot"]  
  
ENV CVS_USER cvsuser  
ENV CVS_PASSWD cvspass  
  
CMD ["/run.sh"]  

