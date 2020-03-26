FROM registry.access.redhat.com/rhel7:7.4-129
MAINTAINER Student <student@example.com>

RUN yum -y install --disablerepo "*" --enablerepo rhel-7-server-rpms \
      httpd php php-mysql php-gd openssl psmisc && \
    yum clean all

ADD scripts /scripts 
RUN chmod 755 /scripts/*

COPY latest.tar.gz /latest.tar.gz
RUN tar xvzf /latest.tar.gz -C /var/www/html --strip-components=1 && \
    rm /latest.tar.gz && \
    usermod -u 27 apache && \
    sed -i 's/^Listen 80/Listen 8080/g' /etc/httpd/conf/httpd.conf && \
    APACHE_DIRS="/var/www/html /usr/share/httpd /var/log/httpd /run/httpd" && \
    chown -R apache:0 ${APACHE_DIRS} && \
    chmod -R g=u ${APACHE_DIRS}

EXPOSE 8080
VOLUME /var/www/html/wp-content/uploads /var/log/httpd /run/httpd
USER apache
CMD ["/bin/bash", "/scripts/start.sh"]
