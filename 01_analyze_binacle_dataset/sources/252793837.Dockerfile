FROM debian:wheezy  
MAINTAINER Darius Bakunas-Milanowski <bakunas@gmail.com>  
  
RUN apt-get update -yqq && apt-get install -yqq \  
apache2 \  
dnsutils \  
host \  
php5 \  
libapache2-mod-php5 \  
php5-curl \  
php5-gd \  
php5-mysql \  
supervisor \  
wget  
  
COPY kippo-graph.conf /etc/apache2/sites-available/kippo-graph.conf  
  
# add config for supervisord  
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf  
COPY entrypoint.sh /entrypoint.sh  
  
WORKDIR /opt  
  
RUN wget http://bruteforce.gr/wp-content/uploads/kippo-graph-1.5.1.tar.gz && \  
tar zxvf kippo-graph-1.5.1.tar.gz && \  
chown -R www-data:www-data kippo-graph-1.5.1 && \  
ln -s kippo-graph-1.5.1 kippo-graph && rm *.tar.gz && \  
chmod 777 /opt/kippo-graph/generated-graphs && \  
cp -p /opt/kippo-graph/config.php.dist /opt/kippo-graph/config.php && \  
chmod 644 /etc/apache2/sites-available/kippo-graph.conf && \  
a2ensite kippo-graph.conf && \  
a2dissite default && \  
a2dissite default-ssl && \  
chmod +x /entrypoint.sh  
  
EXPOSE 80  
  
ENTRYPOINT ["/entrypoint.sh"]  
  
# start supervisor on launch  
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]  

