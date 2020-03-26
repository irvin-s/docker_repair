FROM debian:stretch AS common  
  
RUN addgroup --system postfix \  
&& addgroup --system postdrop \  
&& adduser --system --home /var/spool/postfix \  
\--no-create-home --disabled-password --ingroup postfix postfix  
  
FROM common AS build  
  
# install build requires  
RUN apt-get update \  
&& apt-get install -y debhelper po-debconf groff-base patch \  
lsb-release libdb-dev libldap2-dev liblmdb-dev libpcre3-dev \  
default-libmysqlclient-dev libmariadbclient-dev libssl-dev \  
libsasl2-dev libpq-dev libcdb-dev dpkg-dev libsqlite3-dev \  
html2text libicu-dev \  
&& apt-get clean  
  
ADD postfix /usr/src/postfix  
WORKDIR /usr/src/postfix  
  
# build  
RUN make makefiles \  
shared=yes pie=yes dynamicmaps=yes \  
daemon_directory=/usr/lib/postfix/sbin \  
shlibs_directory=/usr/lib/postfix \  
manpage_directory=/usr/share/man \  
sample_directory=/usr/share/doc/postfix-doc/examples \  
readme_directory=/usr/share/doc/postfix \  
html_directory=/usr/share/doc/postfix/html \  
&& make  
  
RUN make non-interactive-package install_root=/buildroot  
  
FROM common  
  
RUN apt-get update \  
&& apt-get install -y libdb5.3 libldap-2.4-2 liblmdb0 libpcre3 \  
libmariadbclient18 libssl1.1 libsasl2-2 libpq5 libcdb1 libsqlite3-0 \  
libicu57 inetutils-syslogd \  
&& apt-get clean  
  
COPY \--from=build /buildroot /  
RUN /usr/sbin/postfix set-permissions  
  
ADD docker/syslog.conf /etc/syslog.conf  
  
COPY docker/entrypoint.sh /usr/local/bin/  
ENTRYPOINT ["entrypoint.sh"]  
CMD []  
  
EXPOSE 25  
  
  

