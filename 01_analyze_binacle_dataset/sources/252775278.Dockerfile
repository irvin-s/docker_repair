FROM debian:wheezy  
  
RUN \  
apt-get update && \  
apt-get install -y vsftpd && \  
apt-get clean  
  
ENV FTP_DIR /var/ftp  
  
RUN \  
echo "local_enable=YES" >> /etc/vsftpd.conf && \  
echo "write_enable=YES" >> /etc/vsftpd.conf && \  
echo "local_umask=022" >> /etc/vsftpd.conf && \  
sed -i "s/anonymous_enable=YES/anonymous_enable=NO/" /etc/vsftpd.conf && \  
mkdir -p /var/run/vsftpd/empty && \  
mkdir -p $FTP_DIR && \  
chmod 755 $FTP_DIR && \  
groupadd ftp-users && \  
useradd -g ftp-users -d $FTP_DIR beetaa && \  
echo beetaa:beetaa | /usr/sbin/chpasswd && \  
chown beetaa:ftp-users $FTP_DIR && \  
sed -i "s/^\\(auth\\)/# \1/g" /etc/pam.d/vsftpd  
  
VOLUME $FTP_DIR  
  
EXPOSE 21  
CMD chown beetaa:ftp-users $FTP_DIR && vsftpd /etc/vsftpd.conf  

