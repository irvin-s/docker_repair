FROM debian:latest  
RUN apt-get update && apt-get install -y \  
apache2 \  
php5 \  
libapache2-mod-php5  
RUN /etc/init.d/apache2 start  
CMD /bin/bash  

