FROM chambana/base:latest  
  
MAINTAINER Josh King <jking@chambana.net>  
  
RUN apt-get -qq update && \  
apt-get install -y --no-install-recommends amavisd-new \  
clamav \  
clamav-daemon \  
clamav-freshclam \  
pyzor \  
razor \  
cron \  
rsyslog \  
spamassassin \  
supervisor \  
gpg && \  
apt-get clean && rm -rf /var/lib/apt/lists/*  
  
VOLUME ["/var/lib/amavis/.spamassassin"]  
  
RUN gpasswd -a clamav amavis  
RUN gpasswd -a amavis clamav  
  
ADD files/spamassassin/local.cf /etc/spamassassin/local.cf  
ADD files/default.spamassassin /etc/default/spamassassin  
ADD files/amavis/50-user /etc/amavis/conf.d/50-user  
ADD files/clamav/clamd.conf /etc/clamav/clamd.conf  
ADD files/rsyslog/rsyslog.conf /etc/rsyslog.conf  
RUN freshclam  
RUN chown -R clamav:clamav /var/lib/clamav  
  
ADD files/supervisor/supervisord.conf /etc/supervisor/supervisord.conf  
  
EXPOSE 10024  
## Add startup script.  
ADD bin/run.sh /app/bin/run.sh  
RUN chmod 0755 /app/bin/run.sh  
  
ENTRYPOINT ["/app/bin/run.sh"]  
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]  

