#BUILD_PUSH=hub,quay
#BUILD_PUSH_TAG_FROM=PHP_VERSION
FROM bigm/php-56-fpm

### add postfix daemon
RUN /xt/tools/_apt_install postfix heirloom-mailx
# rsyslog pfqueue ?

### replace ssmtp with postfix
RUN rm -f /xt/startup/00ssmtp \
  && echo 'sendmail_path = "/usr/sbin/sendmail -t -i"' > /usr/local/etc/php/conf.d/sendmail.ini

ADD supervisor/* /etc/supervisord.d/
ADD startup/* /xt/startup/
ADD tools/* /xt/tools/

VOLUME ["/var/spool/postfix"]
