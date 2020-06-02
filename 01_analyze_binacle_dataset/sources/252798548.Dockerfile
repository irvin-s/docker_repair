FROM debian:9  
RUN set -uex; \  
apt-get update; \  
apt-get install -y rsyslog; \  
apt-get clean; \  
rm -rf /var/lib/apt/lists/*  
  
COPY rsyslog.conf /etc/rsyslog.conf  
  
CMD [ "/usr/sbin/rsyslogd", "-n" ]  

