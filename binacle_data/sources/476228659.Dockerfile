FROM corebuild

# Guidance from: https://github.com/openshift/sti-php/blob/master/5.6/Dockerfile.rhel7
MAINTAINER docker@softwarecollections.org

ENV PHP_VERSION 5.6
ENV HTTPD_VERSION 2.4

RUN yum-config-manager --enable rhel-server-rhscl-7-rpms --enable rhel-7-server-optional-rpms && \
    yum install -y --nogpgcheck --setopt=tsflags=nodocs httpd24 rh-php72 rh-php72-php rh-php72-php-fpm rh-php72-php-mysqlnd && \
    yum clean all && \
    rm -rf /var/cache/yum/*

COPY ./contrib/ /root/contrib

# In order to drop the root user, we have to make some directories world
# writeable as OpenShift default security model is to run the container under
# random UID.
RUN mkdir -p /var/www/html && \
    mkdir -p /var/www/cgi-bin && \
    sed -i -f /root/contrib/etc/httpdconf.sed /opt/rh/httpd24/root/etc/httpd/conf/httpd.conf && \
    sed -i '/php_value session.save_path/d' /opt/rh/httpd24/root/etc/httpd/conf.d/rh-php72-php.conf && \
    sed -i '/http2_module modules\/mod_http2.so/d' /opt/rh/httpd24/root/etc/httpd/conf.modules.d/00-base.conf && \
    head -n151 /opt/rh/httpd24/root/etc/httpd/conf/httpd.conf | tail -n1 | grep "AllowOverride All" || exit && \
    mkdir /tmp/sessions && \
    chmod -R a+rwx /etc/opt/rh/rh-php72 && \
    chmod -R a+rwx /opt/rh/httpd24/root/var/run/httpd && \
    chmod -R a+rwx /var/opt/rh/rh-php72/run/php-fpm/ && \
    chmod -R a+rwx /var/www/html/ && \
    chmod -R a+rwx /tmp/sessions && \
    chown -R 1001:0 /tmp/sessions /usr/src /var/www/html

EXPOSE 8080 8443
USER 1001

ADD ./enablehttpd24.sh /etc/profile.d/
ADD ./enablerh-php72.sh /etc/profile.d/
ADD ./php.conf /opt/rh/httpd24/root/etc/httpd/conf.d/
ADD ./info.php /var/www/html/
ADD ./cmd.sh /

CMD ["/cmd.sh"]
