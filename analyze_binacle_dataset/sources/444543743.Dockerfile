FROM alpine:3.8

### Install requirement packeges
RUN apk update
RUN apk add \
	apache2 \
	php5-apache2 php5-curl php5-json \
	git

### make dir for apache process id
RUN mkdir -p /run/apache2 \
 	&& chmod -R 755 /run/apache2

### Remove network dependency from apache2 start-up script
RUN sed -i '/need net/d' /etc/init.d/apache2

### Clone Incapsula account-level-dashboard to local directory
WORKDIR /var/www/localhost/htdocs
RUN git clone https://github.com/imperva/account-level-dashboard.git \
	&& chmod -R 777 /var/www/localhost/htdocs \
	&& sed -i 's/localhost\/htdocs/localhost\/htdocs\/account-level-dashboard/g' /etc/apache2/httpd.conf

### Expose port 80 for apache2 service
EXPOSE 80
STOPSIGNAL SIGTERM

### Start-up apache2 service in the background
CMD ["httpd", "-D",  "FOREGROUND"]

