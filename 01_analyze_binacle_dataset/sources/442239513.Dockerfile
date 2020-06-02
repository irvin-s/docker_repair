# Apache
#
# VERSION               0.0.1
#
#


FROM     ubuntu:latest
MAINTAINER Jonas Colmsjö "jonas@gizur.com"

RUN echo "export HOME=/root" >> /root/.profile

RUN apt-get update
RUN apt-get install -y wget nano curl git


#
# Install Apache
#

RUN apt-get install -y apache2
RUN a2enmod rewrite status
#ADD ./etc-apache2-mods-available-status.conf /etc/apache2/mods-available/status.conf

#RUN rm /var/www/html/index.html
RUN echo "<html><body><h1>Hello world!</h1></body></html>" > /var/www/html/hello.html


#
# Start apache
#

# Fix permissions
RUN chown -R www-data:www-data /var/www/html

# Create a volume
RUN mkdir /volume
VOLUME ["/volume"]

EXPOSE 80 443
CMD /usr/sbin/apache2ctl -D FOREGROUND

