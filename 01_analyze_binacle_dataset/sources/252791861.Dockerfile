FROM chambana/base:latest  
  
MAINTAINER Josh King <jking@chambana.net>  
  
ENV SPAMPD_RELAYHOST=smtp:10026  
ENV SPAMPD_HOST=0.0.0.0:10025  
RUN apt-get -qq update && \  
apt-get install -y --no-install-recommends spampd \  
pyzor \  
razor \  
rsyslog \  
supervisor && \  
apt-get clean && rm -rf /var/lib/apt/lists/*  
  
VOLUME ["/var/cache/spampd"]  
  
ADD files/spamassassin/local.cf /etc/spamassassin/local.cf  
ADD files/rsyslog/rsyslog.conf /etc/rsyslog.conf  
ADD files/supervisor/supervisord.conf /etc/supervisor/supervisord.conf  
  
EXPOSE 10025  
## Add startup script.  
ADD bin/run.sh /app/bin/run.sh  
RUN chmod 0755 /app/bin/run.sh  
  
ENTRYPOINT ["/app/bin/run.sh"]  
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]  

