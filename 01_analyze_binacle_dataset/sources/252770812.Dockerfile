######################################################  
#  
# Apache 2.4 Base Image  
# Tag: deardooley/apache:alpine  
#  
# Minimal Apache 2.4 image with CORS, rewrite, and proxy  
# support. Default unified logging to standard out.  
#  
######################################################  
  
FROM alpine:edge  
MAINTAINER Rion Dooley <dooley@tacc.utexas.edu  
  
ADD tcp/limits.conf /etc/security/limits.conf  
ADD tcp/sysctl.conf /etc/sysctl.conf  
  
RUN apk --update add openssl apache2 vim gzip tzdata bash && \  
apk --update add apache2-ssl && \  
rm -f /var/cache/apk/* && \  
  
# Set up system timezone and sync  
echo "Setting system timezone to America/Chicago..." && \  
ln -snf /usr/share/zoneinfo/America/Chicago /etc/localtime && \  
ntpd -d -p pool.ntp.org && \  
  
echo "Updating default apache DocumentRoot..." && \  
mv /var/www/localhost/htdocs /var/www/html && \  
chown -R apache:apache /var/www/html && \  
# sed -i 's#/var/www/localhost/htdocs#%DOCUMENT_ROOT%#g'
/etc/apache2/httpd.conf && \  
# sed -i 's/^ AllowOverride None/ AllowOverride All/' /etc/apache2/httpd.conf
&& \  
# sed -i 's#/var/www/localhost/htdocs#%DOCUMENT_ROOT%#g'
/etc/apache2/conf.d/ssl.conf && \  
# sed -i 's#^SSLMutex .*#Mutex sysvsem default#g' /etc/apache2/conf.d/ssl.conf
&& \  
# sed -i 's#/run/apache2#/etc/apache2/run#g' /etc/apache2/httpd.conf && \  
# sed -i 's#/run/apache2#/etc/apache2/run#g' /etc/apache2/conf.d/ssl.conf && \  
mkdir /etc/apache2/run && \  
rm -f /etc/apache2/conf.d/mpm.conf && \  
rm -f /etc/apache2/conf.d/userdir.conf && \  
  
sed -i 's#Timeout 60#Timeout 43200#' /etc/apache2/conf.d/default.conf  
  
  
ADD apache/httpd.conf /etc/apache2/httpd.conf  
ADD apache/conf.d/* /etc/apache2/conf.d/  
ADD docker_entrypoint.sh /docker_entrypoint.sh  
  
WORKDIR /var/www/html  
  
EXPOSE 80 443  
  
ENTRYPOINT ["/docker_entrypoint.sh"]  
  
CMD ["httpd", "-DFOREGROUND"]  

