FROM wordpress
MAINTAINER Matt Ma "matt@mattmadesign.com"
ENV REFRESHED_AT 2015-08-12

# install the PHP extensions
RUN \
  apt-get -qq update && \
  apt-get -y upgrade && \
  apt-get install -y vim wget && \
  rm -rf /var/lib/apt/lists/*

# Symlink User's "wp-content" folder into the newly installed Wordpress
RUN \
  rm -rf /usr/src/wordpress/wp-content/plugins/* && \
  rm -rf /usr/src/wordpress/wp-content/themes/* && \
  cp -fr /usr/src/wordpress/* /var/www/html/ && \
  chown -R www-data:www-data /var/www/html/

# volume for mysql database and wordpress install
VOLUME ["/var/www/html/vendor", "/var/www/html/wp-content/plugins", "/var/www/html/wp-content/themes"]

# Define working directory.
WORKDIR /var/www/html/

EXPOSE 80 3306

CMD ["apache2-foreground"]
