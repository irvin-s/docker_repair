FROM php:5-apache  
  
ADD html.tar /var/www  
COPY dav_svn.passwd /etc/apache2/  
RUN apt-get update && \  
apt-get install -y subversion libapache2-svn --no-install-recommends && \  
rm -rf /var/lib/apt/lists/* &&\  
chown 33:33 /etc/apache2/dav_svn.passwd &&\  
touch /etc/apache2/dav_svn.authz && \  
chown 33:33 /etc/apache2/dav_svn.authz && \  
chown -R 33:33 /var/www/html && \  
mkdir /svndata && \  
chown -R 33:33 /svndata  
COPY dav_svn.conf /etc/apache2/mods-available/dav_svn.conf  
COPY data /var/www/html/data  
RUN chown -R 33:33 /var/www/html  

