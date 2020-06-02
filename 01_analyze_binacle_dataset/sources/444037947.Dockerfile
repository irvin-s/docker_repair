FROM centos:centos6

MAINTAINER Lars Solberg <lars.solberg@gmail.com>
ENV REFRESHED_AT 2014-08-10
ENV NGINX_VERSION 1.4.4

# centos7 is broken atm because of systemd bug. Use 6 now..
#RUN yum localinstall -y http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-2.noarch.rpm
RUN yum install -y https://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

# Without centosplus, you will get multilib problems when installing openssl-devel
RUN yum install -y --enablerepo=centosplus tar git make gcc pcre-devel openssl-devel python-setuptools python-devel wget

RUN wget https://github.com/jwilder/docker-gen/releases/download/0.3.2/docker-gen-linux-amd64-0.3.2.tar.gz && \
    tar xvzf docker-gen-linux-amd64-0.3.2.tar.gz

# Install nginx and modules (if any)
# To install modules, dowonload them (example via git clone), and add "--add-module=./module-path/" to ./configure
RUN wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz && \
    tar -zxvf nginx-${NGINX_VERSION}.tar.gz && \
    cd nginx-${NGINX_VERSION} && \
    ./configure --with-http_ssl_module --with-http_sub_module --user=www-data --group=www-data --prefix=/usr/local/nginx/ --sbin-path=/usr/local/sbin && \
    make && make install && touch /usr/local/nginx/conf/generated.conf
ADD nginx.conf /usr/local/nginx/conf/nginx.conf

RUN adduser --system www-data

ADD nginx.tmpl /

RUN wget http://mmonit.com/monit/dist/binary/5.8.1/monit-5.8.1-linux-x64.tar.gz && \
    tar -zxvf monit-5.8.1-linux-x64.tar.gz && \
    cp monit-5.8.1/bin/monit /usr/bin/ && \
    cp monit-5.8.1/conf/monitrc /etc/ && \
    echo "include /etc/monit.d/*" >> /etc/monitrc && \
    mkdir /etc/monit.d/

ADD monit-service-docker-gen.conf /etc/monit.d/
ADD monit-service-nginx.conf /etc/monit.d/
RUN chown root:root /etc/monitrc /etc/monit.d/* && chmod 600 /etc/monitrc && chmod 700 /etc/monit.d/*

ADD start /start
RUN chmod 755 /start
ENTRYPOINT ["/bin/bash", "-e", "/start"]
CMD ["start"]

ENV DOCKER_HOST unix:///docker.sock

EXPOSE 80
EXPOSE 443
