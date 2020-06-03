FROM ubuntu
MAINTAINER Matt S. Garrison <matt@mattsgarrison.com>

RUN apt-get update

RUN apt-get install -y vim aptitude

## CREATE USER

RUN useradd -d /home/deployer -m deployer
RUN chown -R deployer:deployer /home/deployer

## MYSQL
#RUN apt-get install -y -q mysql-client libmysqlclient-dev 

## POSTGRES

RUN apt-get install -y -q postgresql-9.1
RUN apt-get install -y -q postgresql-contrib-9.1
RUN apt-get install -y -q libpq-dev
## RUBY
RUN apt-get -y install build-essential git zsh curl wget
RUN apt-get install -y -q ruby1.9.1 ruby1.9.1-dev rubygems1.9.1 irb1.9.1 build-essential libopenssl-ruby1.9.1 libssl-dev zlib1g-dev

## For execjs - needs node
RUN apt-get install -y python-software-properties python python-setuptools 
RUN add-apt-repository ppa:chris-lea/node.js
RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ precise universe" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y nodejs

# SERVICES

## MEMCACHED
RUN apt-get install -y -q memcached

## REDIS for background queues
RUN apt-get install -y -q redis-server
## MAGICK
RUN apt-get install -y -q imagemagick
RUN apt-get install -y -q graphicsmagick
RUN apt-get install -y -q graphicsmagick-libmagick-dev-compat

## Install an updated Ruby
RUN apt-get install -y libyaml-dev ncurses-dev libreadline-dev bison libgdbm-dev libc6-dev libssl-dev libsqlite3-dev make build-essential libssl-dev libreadline6-dev zlib1g-dev libyaml-dev libreadline-ruby libopenssl-ruby libcurl4-openssl-dev libxml2-dev libxslt1-dev libpq-dev gcc

RUN cd /tmp;wget ftp://ftp.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p247.tar.gz
RUN cd /tmp;tar zxfv ruby-2.0.0-p247.tar.gz
RUN cd /tmp/ruby-2.0.0-p247;./configure --prefix=/usr/local
RUN cd /tmp/ruby-2.0.0-p247;make
RUN cd /tmp/ruby-2.0.0-p247;make install
ADD ./templates/environment /etc/environment

## INSTALL RAILS
RUN gem install rails --no-ri --no-rdoc
RUN gem install passenger bundler --no-ri --no-rdoc
## INSTALL RAILS APP
#ADD ./docker-rails /srv/docker-rails
RUN git clone https://github.com/IconoclastLabs/teamweb.git /srv/teamweb-rails
## BUNDLE GEMS
RUN cd /srv/teamweb-rails;bundle install

RUN cd /srv/teamweb-rails;rake db:migrate

## SET FOLDER PERMISSIONS
RUN chown -R deployer:deployer /srv/teamweb-rails

## EXPOSE THE CORRECT PORT (host will proxy this)
EXPOSE 3000

# Tell apt to stop automatically updating NGINX
RUN aptitude hold nginx-full
#RUN easy_install supervisor
#RUN echo_supervisord_conf > /etc/supervisord.conf
#RUN printf "[include]\nfiles = /srv/teamweb-rails/Supervisorfile\n" >> /etc/supervisord.conf

#CMD ["/usr/local/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
#CMD ["/bin/bash/"]

ENTRYPOINT ["/srv/teamweb-rails/"]
CMD ["su", "-", "deployer", "/usr/local/bin/passenger", "start", "/srv/teamweb-rails/"]