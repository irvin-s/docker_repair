FROM centos:centos7
MAINTAINER Imagine Chiu<imagine10255@gmail.com>

ENV SSH_PASSWORD=P@ssw0rd

# Setting DateTime Zone
RUN cp -p /usr/share/zoneinfo/Asia/Taipei /etc/localtime

# Install base tool
RUN yum -y install vim wget tar
RUN yum -y groupinstall development
RUN yum -y install perl-CPAN zlib zlib-devel curl-devel

# Install PHP7-FPM (https://webtatic.com/packages/php71)
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
RUN yum -y install --enablerepo=webtatic-testing php71w-fpm php71w-opcache php71w-cli php71w-gd php71w-imap php71w-mysqlnd php71w-mbstring php71w-mcrypt php71w-pdo php71w-pecl-apcu php71w-pecl-mongodb php71w-pecl-redis php71w-pgsql php71w-xml php71w-xmlrpc

# Install Nginx
RUN rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm && \
    yum -y update nginx-release-centos && \
    cp -p /etc/yum.repos.d/nginx.repo /etc/yum.repos.d/nginx.repo.backup && \
    sed -i -e "s/enabled=1/enabled=0/g" /etc/yum.repos.d/nginx.repo
RUN yum -y --enablerepo=nginx install nginx

# Ensure that PHP5 FPM is run as root.
RUN sed -i -e 's/user = apache/user = nginx/' /etc/php-fpm.d/www.conf
RUN sed -i -e 's/group = apache/group = nginx/' /etc/php-fpm.d/www.conf


# Setting Composer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer && \
    echo 'export PATH="/root/.composer/vendor/bin:$PATH"' >> /root/.bashrc

# Install Supervisor
RUN yum -y install supervisor

# Install crontab service
RUN yum -y install vixie-cron crontabs
RUN sed -ie '/pam_loginuid/d' /etc/pam.d/crond


# Install SSH Service
RUN yum install -y openssh-server passwd
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config && \
    echo "${SSH_PASSWORD}" | passwd "root" --stdin && \
    ssh-keygen -q -t rsa -N '' -f /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -q -t dsa -N '' -f  /etc/ssh/ssh_host_dsa_key && \
    ssh-keygen -q -t ecdsa -N '' -f /etc/ssh/ssh_host_ecdsa_key


# Install Git
RUN wget https://www.kernel.org/pub/software/scm/git/git-2.12.3.tar.gz && \
    tar zxf git-2.12.3.tar.gz && \
    cd git-2.12.3 && \
    ./configure && \
    make && \
    make prefix=/usr/local install && \
    echo "export PATH=$PATH:/usr/local/git/bin" >> /etc/bashrc && \
    source /etc/bashrc


# Delete Install data-info
RUN yum clean all && rm -f /var/log/yum.log


# Add configuration files
COPY conf/nginx.conf /etc/nginx/
COPY conf/supervisord.conf /etc/supervisor/supervisord.conf
COPY conf/www.conf /etc/php-fpm.d/www.conf
COPY sites-module /etc/nginx/sites-module


VOLUME ["/var/www", "/etc/nginx/conf.d"]

EXPOSE 22 80 443 9000

# Executing supervisord
# -n / --nodaemon : runs in foreground ( required for docker )
# -c <configfile> : specifies the config file
ENTRYPOINT /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf