FROM timpark/nodejs
MAINTAINER Tim Park <tpark@microsoft.com>

RUN mkdir /var/www
ADD start.sh /var/www/
RUN chmod +x /var/www/start.sh
CMD ./var/www/start.sh
