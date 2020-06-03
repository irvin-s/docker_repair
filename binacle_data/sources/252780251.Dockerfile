# The image includes:  
#  
# PARENT:  
# - Git  
# - Vim  
# - Node  
# - MySQL Client  
# - PostgreSQL Client  
# - MongoDB  
#  
# THIS:  
# - Apache2 with root  
FROM azukiapp/node  
MAINTAINER Azuki <support@azukiapp.com>  
  
# Install Apache2  
# run `apt-cache showpkg apache2` to get avaliable versions  
ENV APACHE_VERSION 2.4.7  
ENV LINUX_VESION 1ubuntu4.4  
RUN buildDeps='dpkg-dev' \  
&& set -x \  
&& apt-get update -qq \  
&& apt-get install -y -qq $buildDeps \  
&& mkdir -p /var/tmp \  
&& cd /var/tmp \  
&& apt-get source apache2=${APACHE_VERSION} \  
&& cd /var/tmp/apache2-${APACHE_VERSION} \  
&& apt-get build-dep -y -qq apache2 apache2-bin apache2-data \  
&& apache2Deps='libaprutil1-ldap \  
libaprutil1-dbd-sqlite3 \  
libaprutil1-dbd-mysql \  
libaprutil1-dbd-odbc \  
libaprutil1-dbd-pgsql ' \  
&& apt-get install -y -qq $apache2Deps \  
&& DEB_CFLAGS_APPEND='-DBIG_SECURITY_HOLE' dpkg-buildpackage -uc -us -b \  
&& cd .. \  
&& dpkg -i \  
apache2-bin_${APACHE_VERSION}-${LINUX_VESION}_amd64.deb \  
apache2-data_${APACHE_VERSION}-${LINUX_VESION}_all.deb \  
apache2_${APACHE_VERSION}-${LINUX_VESION}_amd64.deb 2>&1 > /dev/null \  
&& sed -i -e "s/www-data/root/g" /etc/apache2/envvars \  
&& . /etc/apache2/envvars \  
&& mkdir -p $APACHE_RUN_DIR $APACHE_LOCK_DIR $APACHE_LOG_DIR \  
&& apt-get clean -qq \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \  
&& apt-get purge -y --auto-remove $buildDeps  
  
ADD default.conf /etc/apache2/sites-available/000-default.conf  
COPY apache2-foreground.sh /usr/bin/apache2-foreground  
  
EXPOSE 80  
CMD ["apache2-foreground"]  

