FROM ruby:2.3
MAINTAINER James Cook <@b00stfr3ak44>

RUN apt-get update && apt-get -y install apache2 php5 git curl sudo \
    libcurl4-openssl-dev apache2-threaded-dev libapr1-dev libaprutil1-dev

RUN git clone https://github.com/pentestgeek/phishing-frenzy.git /var/www/phishing-frenzy

WORKDIR /var/www/phishing-frenzy

RUN gem install --no-rdoc --no-ri passenger -v 5.0.29 && passenger-install-apache2-module

COPY ./database.yml /var/www/phishing-frenzy/config/database.yml

RUN chown -R root:www-data /var/www/phishing-frenzy \
    && chmod -R 755 /var/www/phishing-frenzy/public/uploads/ \
    && bundle install

# RUN rake db:migrate \
#    && rake db:seed \
#    && rake templates:load

RUN mkdir -p /var/www/phishing-frenzy/tmp/pids && mkdir -p /var/www/phishing-frenzy/log/ \
    && echo "www-data ALL=(ALL) NOPASSWD: /etc/init.d/apache2 reload" >> /etc/sudoers
COPY ./apache2.conf /etc/apache2/apache2.conf
COPY ./pf.conf /etc/apache2/pf.conf

RUN chown -R www-data:www-data /var/www/phishing-frenzy/ \
    && chmod -R 755 /var/www/phishing-frenzy/public/uploads/ \
    && chown -R www-data:www-data /etc/apache2/sites-enabled/ \
    && chmod 755 /etc/apache2/sites-enabled/

CMD ["apachectl", "-DFOREGROUND"]
