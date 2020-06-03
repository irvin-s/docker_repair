FROM centos:centos7.5.1804

RUN yum install -y epel-release initscripts

ENV container docker

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]

# named (dns server) service
RUN yum install -y bind bind-utils && \
    systemctl enable named.service && \
    yum -y install httpd; systemctl enable httpd.service && \
    rpm -Uvh http://rpms.remirepo.net/enterprise/remi-release-7.rpm && \
    yum -y install yum-utils && \
    yum -y update && \
    yum-config-manager --enable remi-php72 && \
    yum -y install unzip which wget bzip2 java-1.8.0-openjdk.x86_64 patch nano && \
    yum -y install php git php-mysqlnd php-pdo php-gd php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-soap php-pecl-memcache curl curl-devel php-xdebug php-zip && \
    yum -y install http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm && \
    yum -y install mysql && \
    yum -y install nodejs && \
    yum install -y java Xvfb firefox && \
    yum remove -y firefox && \
    yum clean all

# Install composer and drush
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    mkdir /opt/drush && \
    cd /opt/drush && \
    composer require drush/drush:8.* && \
    ln -s /opt/drush/vendor/bin/drush /usr/local/bin/drush

# Install npm
RUN npm install -g bower

# Install apache solr
RUN mkdir /opt/apache-solr && \
    cd /opt/apache-solr && \
    wget https://archive.apache.org/dist/lucene/solr/3.6.2/apache-solr-3.6.2.zip && \
    unzip -oq apache-solr-3.6.2.zip && \
    rm apache-solr-3.6.2.zip
# Install selenium and firefox
RUN wget http://selenium-release.storage.googleapis.com/2.53/selenium-server-standalone-2.53.0.jar && \
    mv selenium-server-standalone-2.53.0.jar /opt/selenium-server-standalone.jar && \
    wget http://ftp.mozilla.org/pub/mozilla.org/firefox/releases/45.0/linux-x86_64/en-US/firefox-45.0.tar.bz2 && \
    tar -xvjf firefox-45.0.tar.bz2 && \
    rm firefox-45.0.tar.bz2 && \
    mv firefox /usr/local/firefox && \
    ln -s /usr/local/firefox/firefox /usr/local/bin/firefox && \
    echo "export DISPLAY=:99" >> ~/.profile

# Install ImageMagick
RUN yum -y install gcc php-devel php-pear make && \
    yum -y install ImageMagick ImageMagick-devel && \
    pecl install imagick && \
    yum -y remove gcc php-devel php-pear make && \
    yum clean all

COPY docker_files/ /

EXPOSE 80 8983 4444

WORKDIR /var/www/html

CMD ["/usr/sbin/init"]
