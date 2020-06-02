# This is just a template
# To build use the build.sh script
FROM centos:centos7
MAINTAINER Lorenzo Fontana, fontanalorenzo@me.com

WORKDIR /tmp

RUN yum install gcc gcc-c++ kernel-devel libxml2-devel postgresql-devel openssl-devel libcurl-devel libicu-devel readline-devel bzip2-devel tar wget make autoconf re2c -y \
    && cd /tmp; wget -nv -O - ftp://ftp.gnu.org/gnu/bison/bison-2.6.4.tar.gz | tar zx; cd /tmp/bison-2.6.4; ./configure; make -j; make install; rm -Rf /tmp/bison*  \
    && cd /tmp \
    && wget -nv -O - https://github.com/php/php-src/archive/php-VERSION.tar.gz | tar zx \
    && cd /tmp/php-src-php-VERSION \
    && rm -f configure \
    && ./buildconf --force \
    && CONFIGURE_COMMAND \
    && make \
    && make install \
    && rm -Rf /tmp/php* \
    && ln -s /usr/local/php/bin/* /usr/local/bin \
    && ln -s /usr/local/php/sbin/* /usr/local/sbin \
    && yum clean all

WORKDIR /
VOLUME ["/usr/local/php/etc"]
