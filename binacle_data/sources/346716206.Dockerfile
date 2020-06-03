FROM litaio/ruby
MAINTAINER JJ Asghar jjasghar@gmail.com 

ENV PATH "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
 
RUN apt-get update \
    && apt-get install -y libssl-dev git supervisor redis-server \
    && gem install bundler \
    && gem install lita \
    && mkdir -p /srv/lita-docker/ /var/log/supervisor

COPY lita_config.rb /srv/lita-docker/
COPY Gemfile /srv/lita-docker/
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

WORKDIR /srv/lita-docker

RUN bundle install 

CMD ["/usr/bin/supervisord"]
