FROM chambana/base:latest  
  
MAINTAINER Josh King <jking@chambana.net>  
  
RUN apt-get -qq update && \  
apt-get install -y --no-install-recommends micro-httpd \  
uwsgi \  
uwsgi-core \  
mailman \  
postfix \  
postfix-ldap \  
postfix-policyd-spf-python \  
opendkim \  
opendkim-tools \  
rsyslog \  
ca-certificates \  
supervisor && \  
apt-get clean && rm -rf /var/lib/apt/lists/*  
  
ENV POSTFIX_MYNETwORKS 127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128  
ENV POSTFIX_SASL_HOST dovecot  
ENV POSTFIX_SASL_PORT 10143  
ENV POSTFIX_DELIVERY_HOST dovecot  
ENV POSTFIX_DELIVERY_PORT 24  
ENV POSTFIX_SPAM_HOST spam  
ENV POSTFIX_SPAM_PORT 10024  
ENV MAILMAN_DEFAULT_SERVER_LANGUAGE en  
ENV MAILMAN_SPAMASSASSIN_DISCARD_SCORE 8  
ENV MAILMAN_SPAMASSASSIN_HOLD_SCORE 5  
VOLUME ["/var/lib/mailman"]  
  
RUN mkdir -p /etc/postfix/ldap  
ADD files/postfix/main.cf /etc/postfix/main.cf  
ADD files/postfix/master.cf /etc/postfix/master.cf  
ADD files/postfix/ldap/virtual.cf /etc/postfix/ldap/virtual.cf  
  
ADD files/mailman/mm_cfg.py /etc/mailman/mm_cfg.py  
  
ADD files/uwsgi/mailman.ini /etc/uwsgi/mailman.ini  
  
ADD files/rsyslog/rsyslog.conf /etc/rsyslog.conf  
  
ADD files/supervisor/supervisord.conf /etc/supervisor/supervisord.conf  
  
EXPOSE 25 80 587  
## Add startup script.  
ADD bin/run.sh /app/bin/run.sh  
RUN chmod 0755 /app/bin/run.sh  
  
ENTRYPOINT ["/app/bin/run.sh"]  
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]  

