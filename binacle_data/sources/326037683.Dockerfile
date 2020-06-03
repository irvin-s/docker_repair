FROM centos/systemd
MAINTAINER 5team (team@fivemetrics.io)

ENV ROOTDIR /usr/local/app
ENV VERSION 0.1
ENV RELEASE 1
WORKDIR $ROOTDIR

COPY . $ROOTDIR

RUN rpm -hiv https://dl.influxdata.com/influxdb/releases/influxdb-1.6.0.x86_64.rpm \
&& rpm -hiv https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
&& rpm -hiv http://rpms.remirepo.net/enterprise/remi-release-7.rpm \
; yum -y --enablerepo=remi-php71 install php71 php71-php php71-php-cli php71-php-xml php71-php-process \
php71-php-common php71-php-mysqlnd php71-php-pecl-zip php71-php-mbstring php71-php-pdo php71-php-pecl-apcu \
php71-php-pecl-gearman php71-php-opcache php71-php-pecl-redis php71-php-intl \
mariadb-server httpd redis mod_ssl npm nodejs mod_ssl gearmand cronie wget \
; ln -sfn /usr/bin/php71 /usr/bin/php \
; wget https://raw.githubusercontent.com/composer/getcomposer.org/1b137f8bf6db3e79a38a5bc45324414a6b1f9df2/web/installer -O - -q | php -- --quiet \
&& chmod 755 composer.phar \
; mkdir -p $ROOTDIR/src/ \
&& mkdir -p $ROOTDIR/vendor/nelmio/api-doc-bundle/Resources/views/SwaggerUi \
&& mkdir -p /usr/lib/systemd/system/ \
&& mkdir -p /etc/app/gearman/ \
&& mkdir -p /etc/app/collector/ \
&& mkdir -p /etc/httpd/conf.d/ \
&& mkdir -p /etc/logrotate.d/ \
&& mkdir -p /etc/my.cnf.d/ \
&& mkdir -p /var/log/app/ \
&& mkdir -p /var/mysqltmp \
&& mkdir -p /usr/local/bin/ \
; /usr/bin/mysql_install_db \
&& chown -R mysql /var/lib/mysql \
&& chown -R mysql /var/mysqltmp \
; /bin/bash -c "/usr/bin/mysqld_safe --datadir='/var/lib/mysql' &" && sleep 5 \
&& /usr/bin/mysql -e "GRANT ALL ON fivemetrics.* TO 'system'@'127.0.0.1' IDENTIFIED BY 'fivemetrics'" \
&& /usr/bin/mysql -e "FLUSH PRIVILEGES" \
; cd $ROOTDIR/interface \
&& npm install \
&& ./build.sh $VERSION-$RELEASE \
&& cd $ROOTDIR/ \
&& ./composer.phar install -n \
; cp -a $ROOTDIR/interface/dist/css $ROOTDIR/public \
&& cp -a $ROOTDIR/interface/dist/imgs $ROOTDIR/public \
&& cp -a $ROOTDIR/interface/dist/js $ROOTDIR/public \
&& cp -a $ROOTDIR/interface/dist/locales $ROOTDIR/public \
&& cp -a $ROOTDIR/interface/dist/public $ROOTDIR/public \
&& cp -a $ROOTDIR/interface/dist/frontend.php $ROOTDIR/public \
&& cp $ROOTDIR/system/usr/local/bin/gearman_top /usr/local/bin/gearman_top \
&& cp $ROOTDIR/system/usr/local/bin/gcontrol /usr/local/bin/gcontrol \
&& cp $ROOTDIR/system/usr/local/bin/collector /usr/local/bin/collector \
&& cp $ROOTDIR/system/usr/local/bin/account-cleaner /usr/local/bin/account-cleaner \
&& cp $ROOTDIR/system/usr/local/bin/gworker-runner /usr/local/bin/gworker-runner \
&& cp $ROOTDIR/system/usr/lib/systemd/system/gcontrol.service /usr/lib/systemd/system/gcontrol.service \
&& cp $ROOTDIR/system/usr/lib/systemd/system/collector.service /usr/lib/systemd/system/collector.service \
&& cp $ROOTDIR/system/etc/app/gearman/conf.json /etc/app/gearman/conf.json \
&& cp $ROOTDIR/system/etc/httpd/conf.d/app.conf /etc/httpd/conf.d/ \
&& cp $ROOTDIR/system/etc/httpd/conf.d/deflate.conf /etc/httpd/conf.d/ \
&& cp $ROOTDIR/system/etc/httpd/conf.d/expire.conf /etc/httpd/conf.d/ \
&& cp $ROOTDIR/system/etc/my.cnf.d/fivemetrics.cnf /etc/my.cnf.d/ \
&& cp $ROOTDIR/src/FrontendBundle/Resources/views/api/index.html.twig $ROOTDIR/vendor/nelmio/api-doc-bundle/Resources/views/SwaggerUi/index.html.twig \
&& cp $ROOTDIR/system/etc/logrotate.conf /etc/logrotate.conf \
&& cp $ROOTDIR/system/etc/logrotate.d/fivemetrics /etc/logrotate.d/fivemetrics \
&& php $ROOTDIR/bin/console doctrine:database:create \
&& php $ROOTDIR/bin/console doctrine:schema:create \
&& php $ROOTDIR/bin/console doctrine:fixtures:load -n \
&& php $ROOTDIR/bin/console app:nosql:fixtures:load -n \
&& php $ROOTDIR/bin/console cache:clear --env prod \
&& php $ROOTDIR/bin/console cache:clear --env dev \
; sed -i 's/ --no-sqs//;s/ExecStart=\(.*\)/ExecStart=\1 --no-sqs/' /usr/lib/systemd/system/collector.service \
&& sleep 3 \
&& chown -R apache. /var/log/app/ \
&& chmod -R 755 /usr/local/bin/ \
&& echo "*/5 * * * * root /usr/bin/php /usr/local/app/bin/console app:nosql:fixtures:collect >/dev/null" > /etc/cron.d/fivemetrics_collect \
&& /bin/sed -i 's|/public/|/|g' /etc/httpd/conf/httpd.conf \
&& sed -i 's/^extension=curl.so/;extension=curl.so/' /etc/opt/remi/php71/php.d/20-curl.ini \
&& sed -i '/^[^#]/s/^/#/' /etc/httpd/conf.d/welcome.conf \
&& sed -i 's|^DocumentRoot.*|DocumentRoot "/usr/local/app/public/"|' /etc/httpd/conf/httpd.conf \
&& chown -R apache: $ROOTDIR/ \
&& fgrep -q 'TraceEnable Off' /etc/httpd/conf/httpd.conf || sed -i '21iTraceEnable Off\n' /etc/httpd/conf/httpd.conf \
&& sed -i 's/expose_php.*/expose_php = off/' /etc/opt/remi/php71/php.ini \
&& sed -i 's/memory_limit = 128M/memory_limit = 1024M/' /etc/opt/remi/php71/php.ini \
; systemctl enable redis \
&& systemctl enable collector \
&& systemctl enable gearmand \
&& systemctl enable httpd \
&& systemctl enable mariadb \
&& systemctl enable gcontrol \
; cp -fa $ROOTDIR/system/usr/local/bin/systemctl /usr/bin/systemctl

EXPOSE 80 443 3306 8086

CMD ["/usr/bin/systemctl"]
