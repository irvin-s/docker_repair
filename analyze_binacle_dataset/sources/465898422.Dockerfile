FROM richarvey/nginx-php-fpm:latest
COPY src/ /var/www/html
COPY flag /flag
COPY default.conf /etc/nginx/sites-enabled/default.conf
RUN chmod 555 /var/www/html
RUN chmod 555 /flag

WORKDIR /var/www/html
RUN chmod 555 *
RUN chmod 555 /etc/nginx/sites-enabled/default.conf
RUN chmod 555 /etc/nginx/nginx.conf
COPY start.sh /start.sh
RUN chmod +x /start.sh
RUN echo "root:4KfknqnVaHq2EMN2z6dSCGdqSVJKkk" | chpasswd
