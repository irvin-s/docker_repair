FROM google/cloud-sdk  
MAINTAINER Allen Day "allenday@allenday.com"  
EXPOSE 443  
ENV IMAGE_PACKAGES="apache2 bwa gzip kalign tar wget"  
RUN apt-get -y update  
RUN apt-get -y --no-install-recommends install $IMAGE_PACKAGES  
RUN a2enmod cgi  
RUN a2enmod ssl  
  
COPY fqdn.conf /etc/apache2/conf-available/fqdn.conf  
RUN a2enconf fqdn  
  
RUN mkdir -p /data  
RUN mkdir -p /etc/apache2/ssl  
  
RUN rm -rf /var/lib/apt/lists/*  
  
COPY bwa.cgi /usr/lib/cgi-bin/bwa.cgi  
RUN chmod +x /usr/lib/cgi-bin/bwa.cgi  
  
COPY kalign.cgi /usr/lib/cgi-bin/kalign.cgi  
RUN chmod +x /usr/lib/cgi-bin/kalign.cgi  
  
COPY apache2.conf /etc/apache2/sites-available/000-default.conf  
COPY ssl-info.txt /tmp/ssl-info.txt  
COPY entrypoint.sh /entrypoint.sh  
  
ENTRYPOINT bash /entrypoint.sh $BWA_FILES  

