FROM debian:stretch  
COPY pureftpd-mysql.conf /etc/  
COPY start.sh /  
RUN echo "deb http://http.debian.net/debian stretch main\n\  
deb-src http://http.debian.net/debian stretch main\n\  
deb http://http.debian.net/debian stretch-updates main\n\  
deb-src http://http.debian.net/debian stretch-updates main\n\  
deb http://security.debian.org stretch/updates main\n\  
deb-src http://security.debian.org stretch/updates main\n\  
" > /etc/apt/sources.list  
RUN apt-get -y update && \  
apt-get -y \--force-yes --fix-missing install dpkg-dev debhelper && \  
apt-get -y build-dep pure-ftpd && \  
apt-get -y install openbsd-inetd rsyslog openssl && \  
apt-get -y update && mkdir /tmp/pure-ftpd/ && \  
cd /tmp/pure-ftpd/ && \  
apt-get source pure-ftpd && \  
cd pure-ftpd-* && \  
./configure --with-tls --with-mysql && \  
sed -i '/^optflags=/ s/$/ --without-capabilities/g' ./debian/rules && \  
dpkg-buildpackage -b -uc && \  
dpkg -i /tmp/pure-ftpd/pure-ftpd-common*.deb && \  
dpkg -i /tmp/pure-ftpd/pure-ftpd-mysql_*.deb && \  
rm -rf /var/lib/apt/lists/* && chmod 700 /start.sh  
CMD ["/start.sh"]

