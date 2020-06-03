FROM ubuntu:14.04

# Some basic things to make sure the image is happy
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl
ENV DEBIAN_FRONTEND noninteractive

# Update & install packages
RUN apt-get update
RUN apt-get install -y nginx mysql-client php5-cli php5-fpm python-setuptools vim php5-mysql php5-curl curl fortune

# tell Nginx to stay foregrounded
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Copy the website configuration for Nginx
ADD ./etc/nginx/sites-available/default/example.conf /etc/nginx/sites-available/default

# Un-Daemonize php-fpm 
RUN sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php5/fpm/php-fpm.conf

#Let env variables persist
RUN sed -i -e "s/;clear_env\s*=\s*no/clear_env = no/g" /etc/php5/fpm/pool.d/www.conf

# Install Supervisord & copy configuration file
RUN /usr/bin/easy_install supervisor
RUN /usr/bin/easy_install supervisor-stdout
ADD ./etc/supervisord.conf /etc/supervisord.conf

# Copy HTML & PHP files
ADD ./usr/share/nginx/html/index.html /usr/share/nginx/html/index.html
ADD ./usr/share/nginx/html/random/index.php /usr/share/nginx/html/random/index.php

# Copy start up script
ADD ./usr/local/bin/start.sh /usr/local/bin/start.sh
RUN chmod 755 /usr/local/bin/start.sh

# Run
CMD ["/usr/bin/env", "bash", "/usr/local/bin/start.sh"]
