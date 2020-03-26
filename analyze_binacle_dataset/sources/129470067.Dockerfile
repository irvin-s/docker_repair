FROM ubuntu:16.04

# Install.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip vim wget && \
  rm -rf /var/lib/apt/lists/*


RUN apt-get update
RUN apt-get install -y nginx nginx-extras php php-fpm php-mysql php-mysqli php-geoip php-curl php-gd php-xml php-apcu php-mbstring mysql-client net-tools iputils-ping

ENV VERSION 4.7.4
ENV URL https://files.phpmyadmin.net/phpMyAdmin/${VERSION}/phpMyAdmin-${VERSION}-all-languages.tar.gz
LABEL version=$VERSION

# Download tarball and extract
RUN \
    curl --output phpMyAdmin.tar.gz --location $URL \
    && tar xzf phpMyAdmin.tar.gz \
    && rm -f phpMyAdmin.tar.gz  \
    && mv phpMyAdmin-$VERSION-all-languages /var/www/phpmyadmin \
    && rm -rf /var/www/phpmyadmin/setup/ /var/www/phpmyadmin/examples/ /var/www/phpmyadmin/test/ /var/www/phpmyadmin/po/ /var/www/phpmyadmin/composer.json /var/www/phpmyadmin/RELEASE-DATE-$VERSION \
    && chown -R www-data:www-data /var/www/phpmyadmin ;


RUN /etc/init.d/php7.0-fpm start
RUN /etc/init.d/nginx start


# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root


EXPOSE 80

# Define default command.
CMD ["bash"]
