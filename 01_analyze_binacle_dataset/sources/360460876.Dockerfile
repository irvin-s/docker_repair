FROM debian:jessie

MAINTAINER Jean-François Lépine <jeanfrancois@qualiboo.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y -q libicu52 wget php5-cli curl php5-curl git

WORKDIR /var/work
VOLUME /var/work

RUN wget https://getcomposer.org/composer.phar -O /usr/local/bin/composer
RUN chmod +x /usr/local/bin/composer

# Tools for test
RUN mkdir -p /var/tools
RUN cd /var/tools && composer require "phpunit/phpunit:~5.0.3" "behat/mink-extension:~1.3" "behat/mink-selenium2-driver" "behat/behat:~2.4" "behat/mink" "behat/mink-goutte-driver" "behat/symfony2-extension:~1.1" "behat/mink-browserkit-driver:~1.2" "fabpot/goutte:~1.0"
RUN ln -s /var/tools/vendor/bin/phpunit /usr/bin/phpunit
RUN ln -s /var/tools/vendor/bin/behat /usr/bin/behat

# Config
ADD behat.yml /var/tools/

ENTRYPOINT ["/var/tools/vendor/bin/behat", "-c", "/var/tools/behat.yml"]