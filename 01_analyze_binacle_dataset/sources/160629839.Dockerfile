FROM debian:jessie
MAINTAINER Sam Minnee <sam@silverstripe.com>

### SET UP

RUN apt-get -qq update

RUN apt-get -qqy install sudo wget lynx telnet nano curl make git-core locales bzip2

RUN echo "LANG=en_US.UTF-8\n" > /etc/default/locale && \
	echo "en_US.UTF-8 UTF-8\n" > /etc/locale.gen && \
	locale-gen

# Known hosts
ADD known_hosts /root/.ssh/known_hosts

# APACHE, MYSQL, PHP & SUPPORT TOOLS
RUN DEBIAN_FRONTEND=noninteractive apt-get -qqy install apache2 mysql-server \
	php5-cli libapache2-mod-php5 php5-mysqlnd php5-mcrypt php5-tidy php5-curl php5-gd php-pear

#  - Phpunit, Composer, Phing, SSPak
RUN wget https://phar.phpunit.de/phpunit-3.7.37.phar && \
	chmod +x phpunit-3.7.37.phar && \
	mv phpunit-3.7.37.phar /usr/local/bin/phpunit && \
	wget https://getcomposer.org/composer.phar && \
	chmod +x composer.phar && \
	mv composer.phar /usr/local/bin/composer && \
	pear channel-discover pear.phing.info && \
	pear install phing/phing && \
	curl -sS https://silverstripe.github.io/sspak/install | php -- /usr/local/bin

# SilverStripe Apache Configuration
RUN a2enmod rewrite && \
	rm -r /var/www/html && \
	echo "date.timezone = Pacific/Auckland" > /etc/php5/apache2/conf.d/timezone.ini && \
	echo "date.timezone = Pacific/Auckland" > /etc/php5/cli/conf.d/timezone.ini

ADD apache-foreground /usr/local/bin/apache-foreground
ADD apache-default-vhost /etc/apache2/sites-available/000-default.conf
ADD _ss_environment.php /var/_ss_environment.php

####
## These are not specifically SilverStripe related and could be removed on a more optimised image

# Ruby, RubyGems, Bundler
RUN apt-get -qqy install -t stable ruby ruby-dev gcc && \
	gem install bundler && \
	gem install compass

# NodeJS and common global NPM modules
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash - && \
	apt-get install -qqy nodejs && \
	npm install -g grunt-cli gulp bower

####
## Commands and ports	
EXPOSE 80

VOLUME /var/www

# Run apache in foreground mode, because Docker needs a foreground
WORKDIR /var/www
CMD ["/usr/local/bin/apache-foreground"]

ENV LANG en_US.UTF-8
