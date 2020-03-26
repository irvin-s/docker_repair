FROM clarencep/php7:centos7  
  
# install httpd  
RUN yum install -y httpd \  
&& rm -f /var/www/html/index.html \  
&& echo '<?php phpinfo();' > /var/www/html/index.php \  
&& sed 's|logs/access_log|/dev/stdout|' -i.bak /etc/httpd/conf/httpd.conf \  
&& sed 's|logs/error_log|/dev/stderr|' -i.bak /etc/httpd/conf/httpd.conf \  
&& yum clean all  
  
EXPOSE 80 443  
CMD [ "/usr/sbin/httpd", "-DFOREGROUND" ]  
  

