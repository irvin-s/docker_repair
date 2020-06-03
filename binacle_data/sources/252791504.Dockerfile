FROM lucee/lucee51:latest  
  
RUN apt-get update && \  
apt-get install -y \  
supervisor \  
apache2 apache2.2-common \  
libapache2-mod-shib2 \  
&& \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
COPY config/apache2/ /etc/apache2/  
COPY config/shibboleth/ /etc/shibboleth/  
COPY config/supervisor/ /etc/supervisor/conf.d/  
COPY shibd-foreground.sh /usr/bin/shibd-foreground.sh  
RUN chmod +x /usr/bin/shibd-foreground.sh  
  
ONBUILD RUN rm -rf /var/www/*  
  
EXPOSE 80 443  
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]  

