FROM ubuntu:14.04  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update \  
&& apt-get install -y -q \  
opendkim \  
opendkim-tools \  
postfix \  
rsyslog \  
sasl2-bin \  
spamassassin \  
spamc \  
libmail-dkim-perl \  
libcrypt-openssl-random-perl \  
libcrypt-openssl-rsa-perl \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
COPY docker-entrypoint.sh /  
  
RUN chmod +x /docker-entrypoint.sh  
  
COPY config/postfix/main.cf /etc/postfix/main.cf  
COPY config/postfix/sasl/smtpd.conf /etc/postfix/sasl/smtpd.conf  
COPY config/postfix/master.cf /etc/postfix/master.cf  
COPY config/sasl/saslauthd /etc/default/saslauthd  
COPY config/spamassassin/spamassassin /etc/default/spamassassin  
COPY config/spamassassin/local.cf /etc/spamassassin/local.cf  
COPY config/opendkim/opendkim.conf /etc/opendkim.conf  
COPY config/opendkim/opendkim /etc/default/opendkim  
COPY config/opendkim/TrustedHosts /etc/opendkim/TrustedHosts  
  
ENTRYPOINT ["/docker-entrypoint.sh"]  
  
EXPOSE 25  
CMD ["start"]  

