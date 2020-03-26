FROM centos:6.10
LABEL maintainer='Peter Wu <piterwu@outlook.com>'

# 设置时区
ENV TZ="Asia/Shanghai" \
    TERM=xterm

# 添加阿里云yum源
ADD install/soft/epel-6.repo /etc/yum.repos.d/epel.repo

# 安装软件
RUN yum -y install postfix && \
    yum -y install rsyslog perl-DBI perl-JSON-XS perl-NetAddr-IP perl-Mail-SPF perl-Sys-Hostname-Long && \
    yum -y install freetype* libpng* libjpeg* amavisd-new monit && \
    yum clean all

# 反垃圾邮件设置
RUN chmod -R 770 /var/spool/amavisd/tmp && \
    usermod -G amavis clam

# 安装apache，mysql套件
ADD install/soft/ewomail-lamp-1.0-el6.x86_64.rpm /home/
RUN rpm -ivh /home/ewomail-lamp-1.0-el6.x86_64.rpm

# 安装dovecot
ADD install/soft/dovecot-2.2.24-el6.x86_64.rpm /home/
RUN rpm -ivh /home/dovecot-2.2.24-el6.x86_64.rpm

ADD install/soft/postfix-policyd-spf-perl /usr/libexec/postfix/
RUN chmod -R 755 /usr/libexec/postfix/postfix-policyd-spf-perl

# 集中清理安装包
RUN rm -rf /home/*.rpm && \
    rpm --rebuilddb && \
    yum clean all && rm -rf /var/cache/yum

# 添加配置文件
ADD install/config/monit    /etc/monit
ADD install/config/dovecot    /etc/dovecot
ADD install/config/postfix    /etc/postfix
ADD install/soft/httpd.init   /etc/rc.d/init.d/httpd
ADD install/soft/httpd.conf   /ewomail/apache/conf/httpd.conf
ADD install/soft/php.ini      /ewomail/php54/etc/
ADD install/soft/php-cli.ini  /ewomail/php54/etc/
ADD install/soft/dovecot.init /etc/rc.d/init.d/dovecot
ADD install/config/mail     /ewomail/cmail

# 清理换行
RUN sed -i 's/\r$//' /etc/rc.d/init.d/httpd && \
    sed -i 's/\r$//' /etc/rc.d/init.d/dovecot

RUN ln -s /etc/amavisd/amavisd.conf /etc && \
    chmod -R 700 /etc/monit && \
    mv /etc/clamd.conf /etc/clamd.conf.backup && \
    cp -rf /etc/clamd.d/amavisd.conf /etc/clamd.conf  && \
    mkdir -p /etc/ssl/certs && \
    mkdir -p /etc/ssl/private && \
    chmod -R 755 /etc/rc.d/init.d/httpd && \
    chmod -R 755 /etc/rc.d/init.d/dovecot

# 生成签名
RUN chmod 755 /usr/local/dovecot/share/doc/dovecot/mkcert.sh && \
    cd /usr/local/dovecot/share/doc/dovecot/ && \
    sh mkcert.sh && \
    mkdir -p /ewomail/dkim && \
    chown -R amavis:amavis /ewomail/dkim && \
    amavisd genrsa /ewomail/dkim/mail.pem && \
    chown -R amavis:amavis /ewomail/dkim && \
    echo "\$signed_header_fields{'received'} = 0;" >> /etc/amavisd/amavisd.conf && \
    echo "\$signed_header_fields{'to'} = 1;" >> /etc/amavisd/amavisd.conf && \
    echo "\$originating = 1;" >> /etc/amavisd/amavisd.conf && \
    echo "" >> /etc/amavisd/amavisd.conf && \
    echo "# Add dkim_key here." >> /etc/amavisd/amavisd.conf && \
    echo 'dkim_key("$mydomain", "dkim", "/ewomail/dkim/mail.pem");' >> /etc/amavisd/amavisd.conf && \
    echo "" >> /etc/amavisd/amavisd.conf && \
    echo "@dkim_signature_options_bysender_maps = ({" >> /etc/amavisd/amavisd.conf && \
    echo "# catchall defaults" >> /etc/amavisd/amavisd.conf && \
    echo "'.' => {c => 'relaxed/simple', ttl => 30*24*3600 }," >> /etc/amavisd/amavisd.conf && \
    echo "} );"  >> /etc/amavisd/amavisd.conf

# 拷贝admin和rainloop
ADD ewomail-admin/      /ewomail/www/ewomail-admin
ADD rainloop/           /ewomail/www/rainloop
ADD install/config/rainloop/_data_/           /ewomail/www/rainloop_data_
# ADD  install/soft/phpMyAdmin.tar.gz  /ewomail/www/

RUN groupadd -g 5000 vmail && \
    useradd -M -u 5000 -g vmail -s /sbin/nologin vmail && \
    mkdir -p /ewomail/mail && \
    chown -R vmail:vmail /ewomail/mail && \
    chmod -R 700 /ewomail/mail && \    
    chown -R www:www /ewomail/www && \
    chmod -R 770 /ewomail/www && \
    mkdir -p /ewomail/mysql/data && \    
    chown -R mysql:mysql /ewomail/mysql/data

ADD docker/init_sql.php          /home/
ADD docker/update_file.php       /home/
ADD docker/entrypoint.sh         /home/
RUN chmod -R 700 /home/init_sql.php && \
    chmod -R 700 /home/update_file.php && \
    chmod -R 700 /home/entrypoint.sh && \
    rm -rf /ewomail/nginx

ENV MYSQL_ROOT_PASSWORD=mysql \
    MYSQL_MAIL_PASSWORD=123456 \
    URL='*:8080' \
    WEBMAIL_URL='*' \
    TITLE='ewomail.com' \
    COPYRIGHT='Copyright © 2016-2017 | ewomail.com 版权所有' \
    ICP='ICP证：粤ICP备**********号' \
    LANGUAGE='zh_CN' \
    MONIT_MAILSERVER='' \
    MONIT_MAIL_PORT='25' \
    MONIT_MAIL_USER='' \
    MONIT_MAIL_PASSWORD='' \
    MONIT_MAIL_ALERT='' \
    MONIT_USER='admin' \
    MONIT_PASSWORD='monit'

EXPOSE 25 109 110 143 465 587 993 995 80 8080 2812

VOLUME ["/ewomail/mysql/data","/ewomail/mail","/ewomail/www/rainloop/data"]

ENTRYPOINT ["/home/entrypoint.sh"]

