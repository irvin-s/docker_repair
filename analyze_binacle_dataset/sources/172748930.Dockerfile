FROM rails:4.2.3

MAINTAINER Eliot Jordan <eliot.jordan@gmail.com>

RUN apt-get update && apt-get upgrade -y && \
    apt-get -y install \
        unzip \
        wget \
        git \
        curl

WORKDIR /usr/src

RUN rails new geoblacklight -m https://raw.githubusercontent.com/geoblacklight/geoblacklight/master/template.rb

WORKDIR /usr/src/geoblacklight

# Add postgres gem
RUN echo "\ngem 'pg'" >> Gemfile

RUN bundle install

# Install unicorn
RUN gem install unicorn

# Setup Unicorn
ADD unicorn.rb /usr/src/geoblacklight/config/unicorn.rb
RUN mkdir /var/www && mkdir /var/www/gbl && mkdir /var/www/gbl/pids && mkdir /var/www/gbl/log/

# Add default env variable referencing our solr container
# Depends on --link my_solr_container:solr
ENV SOLR_URL http://solr:8983/solr/geoblacklight

# Add start-up script
ADD start.sh /usr/src/geoblacklight/start.sh

VOLUME ["/usr/src/geoblacklight/tmp"]

EXPOSE 3000

CMD ["sh", "-c", "/usr/src/geoblacklight/start.sh"]