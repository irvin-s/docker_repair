FROM centos:latest
MAINTAINER "The CentOS Project" <admin@jiobxn.com>
ARG LATEST="0"
ARG ZEND="0"

RUN \cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN yum clean all; yum -y install epel-release; yum -y update \
        && yum clean all; yum -y update; yum -y install net-tools bash-completion vim wget libnghttp2-devel openssl openssl-devel expat-devel make gcc-c++ iptables cronie \
        && yum clean all

RUN cd /usr/local/src \
        && wget -c "$(curl -s http://httpd.apache.org/download.cgi |grep tar.gz |awk -F\" 'NR==1{print $2}')" \
        && wget -c "$(curl -s https://apr.apache.org/download.cgi |grep tar.gz |awk -F\" 'NR==1{print $2}')" \
        && wget -c "$(curl -s https://apr.apache.org/download.cgi |grep tar.gz |awk -F\" 'NR==4{print $2}')"

RUN cd /usr/local/src \
        && if [ "${ZEND}" = "1" ]; then MPM="--with-mpm=prefork"; fi \
        && tar zxf httpd-*.tar.gz \
        && tar zxf apr-util-*.tar.gz \
        && \rm apr-util-*.tar.gz \
        && mv apr-util-* new-apr-util \
        && tar zxf apr-*.tar.gz \
        && cd /usr/local/src/apr-* \
        && ./configure  && make -j8 && make install \
        && cd /usr/local/src/new-apr-util \
        && ./configure --prefix=/usr/local/apr-util --with-apr=/usr/local/apr --with-crypto --with-openssl --with-nss \
        && make -j8 && make install \
        && cd /usr/local/src/httpd-* \
        && ./configure --prefix=/usr/local/apache ${MPM} \
           --enable-load-all-modules \
           --enable-modules=all \
           --enable-mods-shared=all \
           --enable-session-crypto \
           --enable-http2 \
           --enable-cgi \
           --with-z=/usr \
           --with-ssl=/usr \
           --with-pcre=/usr \
           --with-libxml2=/usr \
           --with-apr=/usr/local/apr \
           --with-apr-util=/usr/local/apr-util \
        && make -j8 && make install \
        && rm -rf /usr/local/src/* \
        && ln -s /usr/local/apache/bin/* /usr/local/bin/

VOLUME /usr/local/apache/htdocs

COPY httpd.sh /httpd.sh
RUN chmod +x /httpd.sh

ENTRYPOINT ["/httpd.sh"]

EXPOSE 80 443

CMD ["httpd", "-DFOREGROUND"]

# docker build --build-arg ZEND=1 -t httpd .
# docker run -d --restart always -p 10080:80 -p 10443:443 -v /docker/www:/usr/local/apache/htdocs -e PHP_SERVER=redhat.xyz --hostname httpd --name httpd httpd
# docker run -it --rm httpd --help
