FROM centos:centos6
MAINTAINER Imagine Chiu<imagine10255@gmail.com>


ENV SSH_PASSWORD=P@ssw0rd


# Install base tool
RUN yum -y install vim wget tar


# Install develop tool
RUN yum -y groupinstall development


# Install php rpm
RUN rpm --import http://ftp.riken.jp/Linux/fedora/epel/RPM-GPG-KEY-EPEL-6 && \
    rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm


# Install SSH Service
RUN yum install -y openssh-server passwd
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config && \
    echo "${SSH_PASSWORD}" | passwd "root" --stdin


# Install crontab service
RUN yum -y install vixie-cron crontabs


# Install Git need package
RUN yum -y install curl-devel expat-devel gettext-devel devel zlib-devel perl-devel


# Install php-fpm (https://webtatic.com/packages/php56/
RUN yum -y install php56w php56w-fpm php56w-mbstring php56w-xml php56w-mysql php56w-pdo php56w-gd php56w-pecl-imagick php56w-opcache php56w-pecl-memcache php56w-pecl-xdebug


# Install php-mssql,mcrypt
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
RUN yum -y install php56w-mssql php56w-mcrypt


# Install nginx
RUN rpm --import http://ftp.riken.jp/Linux/fedora/epel/RPM-GPG-KEY-EPEL-6 && \
    rpm -ivh http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm && \
    yum -y update nginx-release-centos && \
    cp -p /etc/yum.repos.d/nginx.repo /etc/yum.repos.d/nginx.repo.backup && \
    sed -i -e "s/enabled=1/enabled=0/g" /etc/yum.repos.d/nginx.repo
RUN yum -y --enablerepo=nginx install nginx


# Setting composer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer


# Install laravel-envoy
RUN composer global require "laravel/envoy=~1.0"


# Install supervisor
RUN yum -y install python-setuptools && \
    easy_install supervisor && \
    echo_supervisord_conf > /etc/supervisord.conf


# Install MariaDB(Only Client)
RUN echo -e "[mariadb]" >> /etc/yum.repos.d/MariaDB.repo && \
    echo -e "name = MariaDB" >> /etc/yum.repos.d/MariaDB.repo && \
    echo -e "baseurl = http://yum.mariadb.org/10.0/centos6-amd64" >> /etc/yum.repos.d/MariaDB.repo && \
    echo -e "gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB" >> /etc/yum.repos.d/MariaDB.repo && \
    echo -e "gpgcheck=1" >> /etc/yum.repos.d/MariaDB.repo && \
    yum -y install MariaDB-client


# Install Freetds(MSSQL)
RUN cd ~/ && \
    wget ftp://ftp.freetds.org/pub/freetds/stable/freetds-0.95.87.tar.gz && \
    tar zxf ./freetds-0.95.87.tar.gz && \
    cd ./freetds-0.95.87 && \
    ./configure --prefix=/usr/local/freetds && \
    gmake && \
    gmake install && \
    rm -rf ~/freetds-0.95.87*


# Install Git Laster Version
RUN cd ~/ && \
    wget https://www.kernel.org/pub/software/scm/git/git-2.6.3.tar.gz && \
    tar zxf ./git-2.6.3.tar.gz && \
    cd ./git-2.6.3 && \
    ./configure && make && make install && \
    rm -rf ~/git-2.6.3*


# Copy files for setting
ADD . /opt/


# Create Base Enter Cont Command
RUN chmod 755 /opt/docker/bash/init-bashrc.sh && echo "/opt/docker/bash/init-bashrc.sh" >> /root/.bashrc && \
    echo 'export PATH="/root/.composer/vendor/bin:$PATH"' >> /root/.bashrc


# Setting lnmp(php,lnmp)
RUN chmod 755 /opt/docker/bash/setting-lnmp.sh && bash /opt/docker/bash/setting-lnmp.sh


# Setting DateTime Zone
RUN cp -p /usr/share/zoneinfo/Asia/Taipei /etc/localtime


# Setup default path
WORKDIR /home


# Private expose
EXPOSE 22 80 8080


# Volume for web server install
VOLUME ["/home/website","/home/config","/home/logs"]


# Start run shell
CMD ["bash"]
