FROM centos:6  
  
COPY ./rpms /tmp/rpms  
  
RUN yum install -y httpd \  
&& rm -f /var/www/html/index.html \  
&& echo '<?php phpinfo();' > /var/www/html/index.php \  
&& yum install -y gcc make libXpm.so.4 libt1.so.5 autoconf automake gd \  
&& yum install -y openssl openssl-devel readline readline-devel \  
&& yum install -y openssl098e compat-readline5 compat-openldap \  
&& yum install -y libxslt \  
&& echo 'exclude=php*' >> /etc/yum.conf \  
&& cd /tmp/rpms \  
&& rpm -ivh php-common-5.2.17*.rpm \  
&& rpm -ivh php-cli-5.2.17*.rpm \  
&& rpm -ivh php-5.2.17*.rpm \  
&& rpm -ivh php-devel-5.2.17*.rpm \  
&& rpm -ivh php-gd-5.2.17*.rpm \  
&& rpm -ivh php-ldap-5.2.17*.rpm \  
&& rpm -ivh php-mbstring-5.2.17*.rpm \  
&& rpm -ivh php-xml-5.2.17*.rpm \  
&& rpm -ivh php-pdo-5.2.17*.rpm \  
&& useradd mockbuild \  
&& rpm -ivh MySQL-shared-5.0.95-1.glibc23.x86_64.rpm \  
&& rpm -ivh php-mysql-5.2.17*.rpm \  
&& php -v \  
&& yum remove -y gcc autoconf automake \  
&& yum clean all \  
&& find /var/log -type f -print0 | xargs -0 rm -rf /tmp/*  
  
RUN sed 's|logs/access_log|/dev/stdout|' -i.bak /etc/httpd/conf/httpd.conf \  
&& sed 's|logs/error_log|/dev/stderr|' -i.bak /etc/httpd/conf/httpd.conf  
  
CMD [ "/usr/sbin/httpd", "-DFOREGROUND" ]  
  
EXPOSE 80  

