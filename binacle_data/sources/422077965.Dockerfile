FROM centos/php-56-centos7

USER root

RUN yum install -y yum-utils deltarpm && \
    rpm -Uvh https://www.softwarecollections.org/en/scls/remi/php56more/epel-7-x86_64/download/remi-php56more-epel-7-x86_64.noarch.rpm && \
    rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    rpm -Uvh http://rpms.remirepo.net/enterprise/remi-release-7.rpm && \
    yum update -y && \
    yum install -y rh-php56-php-bcmath \
        rh-php56-php-dba \
        rh-php56-php-gmp \
        rh-php56-php-intl \
        rh-php56-php-mbstring \
        rh-php56-php-mcrypt \
        rh-php56-php-odbc \
        rh-php56-php-pdo \
        rh-php56-php-pspell \
        rh-php56-php-snmp \
        rh-php56-php-soap \
        rh-php56-php-xmlrpc  \
        rh-php56-php-pecl-http1 \
        rh-php56-php-pecl-apcu \
        rh-php56-php-devel \
        librdkafka-devel-0.9.1-1.el7.remi.x86_64 && \
    yum clean all && \
    pecl install rdkafka-3.0.0

RUN rm -Rf /opt/rh/httpd24/root/var/run/httpd && \
    mkdir /opt/rh/httpd24/root/var/run/httpd && \
    chmod -R a+rwx /opt/rh/rh-php56/register.content/etc && \
    chmod -R a+rwx /opt/rh/httpd24/root/var/run/httpd && \
    chmod -R a+rwx /tmp/sessions && \
    chmod -R a+rwx /opt/rh/httpd24/root/etc/httpd && \
    chown -R 1001:0 /opt/app-root /tmp/sessions && \
    echo 'extension = rdkafka.so' > /etc/opt/rh/rh-php56/php.d/40-rdkafka.ini

USER 1001
