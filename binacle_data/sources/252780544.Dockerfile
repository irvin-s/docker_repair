FROM debian:latest  
MAINTAINER coolyaolei<coolyaolei@sina.com>  
  
RUN pwd && \  
# Change Mirror For China  
# sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \  
# sed -i 's/deb http:\/\/security.debian.org/#deb
http:\/\/security.debian.org/g' /etc/apt/sources.list && \  
apt-get update && \  
apt-get install -y --no-install-recommends vsftpd db-util && \  
apt-get clean  
  
  
  
  
# for testing  
# RUN apt-get install -y --no-install-recommends procps vim  
ENV FTP_USER admin  
ENV FTP_PASS admin  
ENV PASV_ADDRESS REQUIRED  
ENV PASV_MIN_PORT 46000  
ENV PASV_MAX_PORT 47000  
COPY vsftpd.conf /etc/vsftpd/  
COPY vsftpd_virtual /etc/pam.d/  
COPY run-vsftpd.sh /usr/sbin/  
  
RUN chmod +x /usr/sbin/run-vsftpd.sh && \  
mkdir -p /var/run/vsftpd/empty  
  
VOLUME /home/vsftpd  
VOLUME /var/log/vsftpd  
  
EXPOSE 20 21  
CMD ["/usr/sbin/run-vsftpd.sh"]

