FROM dukegcb/imads  
MAINTAINER john.bradley@duke.edu  
# apache2  
RUN apt-get update \  
&& apt-get install -y apache2 apache2-utils libapache2-mod-wsgi\  
&& apt-get clean  
  
# Configure Apache  
ADD imads.conf /etc/apache2/sites-available/imads.conf  
RUN a2enmod ssl  
RUN a2ensite imads  
  
# Ensure services are stopped so that we can run them  
RUN service apache2 stop  
  
# Volume for certificates  
  
VOLUME /etc/external/  
  
EXPOSE 80  
EXPOSE 443  
  
ADD start-apache.sh /usr/bin/start-apache.sh  
CMD ["start-apache.sh"]  

