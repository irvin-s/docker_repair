FROM prophusion/prophusion-base  
MAINTAINER Mike Baynton <mike@mbaynton.com>  
  
RUN apt-get clean && apt-get update  
  
RUN apt-get install -y vsftpd ftp && apt-get clean  
  
COPY vsftpd.conf /etc/vsftpd.conf  
COPY vsftpd.chroot_list /etc/vsftpd.chroot_list  
COPY vsftpd /etc/init.d/vsftpd  
COPY docker-entrypoint.sh /docker-entrypoint.sh  
COPY files.tar /files.tar  
COPY container-setup.sh /container-setup.sh  
  
RUN /container-setup.sh  
  
EXPOSE 21  
ENTRYPOINT ["/docker-entrypoint.sh"]  

