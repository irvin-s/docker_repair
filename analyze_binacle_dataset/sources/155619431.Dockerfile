# RUN HUE

FROM centos:7

# YUM #

RUN yum install -y wget tar python krb5-server krb5-libs krb5-workstation vim
RUN yum install -y libxslt-devel
RUN yum install -y mysql mysql-connector-java
RUN yum install -y snappy
RUN yum install -y python-devel
RUN yum install -y openssl-devel
RUN yum install -y libxslt-devel
RUN yum install -y cyrus-sasl-gssapi unzip

# Custom Dependencies #

COPY hue-build.tar.gz /var/lib/

# Hue Layout #

RUN groupadd {{user}} -g {{gid}}
RUN useradd {{user}} -u {{uid}} -g {{gid}} -d /var/lib/hue
RUN mkdir -p /var/lib/hue/ssl

# Fix hue request verify path: setting the ca bundle path as global env variable

USER {{user}}

#  Hue INSTALL   #

RUN tar -C /var/lib/hue -xzf /var/lib/hue-build.tar.gz --strip-components 1
RUN rm -f /var/lib/hue/desktop/conf/pseudo-distributed.ini
USER root
RUN rm -f /var/lib/hue-build.tar.gz
USER {{user}}


COPY hue_init.sh /var/lib/hue/

USER root
RUN date
RUN chmod +x /var/lib/hue/hue_init.sh
RUN unlink /etc/localtime 
RUN echo 'ZONE="Europe/Paris"'> /etc/sysconfig/clock
RUN ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime
RUN date
USER {{user}}

ENTRYPOINT ["/var/lib/hue/hue_init.sh"]
