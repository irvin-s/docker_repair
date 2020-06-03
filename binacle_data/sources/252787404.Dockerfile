FROM ubuntu  
  
# File Author / Maintainer  
MAINTAINER brigzzy  
  
ADD ./html /var/www/html  
  
# Update the repository sources list  
RUN apt update  
  
# Install and run apache  
RUN apt install -y apache2 php libapache2-mod-php php-mcrypt && apt-get clean  
  
EXPOSE 80  
CMD apachectl -D FOREGROUND  

