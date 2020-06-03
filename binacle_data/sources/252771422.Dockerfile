FROM ajoergensen/baseimage-alpine  
MAINTAINER ajoergensen  
  
RUN \  
apk -U add dovecot && \  
echo "ssl = no" > /etc/dovecot/conf.d/10-ssl.conf && \  
echo "log_path = /dev/stderr" >> /etc/dovecot/conf.d/10-logging.conf && \  
echo "auth_verbose = yes" >> /etc/dovecot/conf.d/10-logging.conf && \  
echo "disable_plaintext_auth = no" >> /etc/dovecot/conf.d/10-auth.conf && \  
echo "auth_mechanisms = plain" >> /etc/dovecot/conf.d/10-auth.conf && \  
rm -rf /var/cache/apk/* /tmp/* /var/tmp/*  
  
# Add service files.  
COPY root/ /  
RUN chmod -v +x /etc/services.d/*/run /etc/cont-init.d/*  
  
EXPOSE 143  
VOLUME /home/app  

