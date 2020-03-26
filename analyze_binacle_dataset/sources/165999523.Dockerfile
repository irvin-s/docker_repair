# Docker for Scumblr
# Author : Nag
# Select ubuntu as the base image
FROM ubuntu:14.04

MAINTAINER Nag <nagwww@gmail.com>

# Dockerfile for a Rails application using Nginx and Unicorn

# Install nginx, nodejs and curl
RUN apt-get update -q
RUN apt-get install -qy nginx
RUN apt-get install -qy curl
RUN apt-get install -qy nodejs
RUN apt-get install -qy git

# Prevent nginx from running in daemon mode
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Retrieve code from github
RUN git clone https://github.com/Netflix/scumblr.git /scumblr 

# Install rvm, ruby, bundler, sidekiq
RUN curl -sSL https://get.rvm.io | bash -s stable
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install 2.0.0-p481"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"
RUN /bin/bash -l -c "gem install sidekiq --no-ri --no-rdoc"

# set WORKDIR
WORKDIR /scumblr

# Install Nokogiri requirements
RUN apt-get install -qy libxslt-dev libxml2-dev

# Install Imagemagick requirements
RUN apt-get install -qy libmagickwand-dev imagemagick libmagickcore-dev

# Install Redis
RUN apt-get install -qy redis-server

# Install Postgres requirements
RUN apt-get install -qy libpq-dev

# bundle install
RUN /bin/bash -l -c "bundle install"

# Copy seed file
ADD config/scumblr/seeds.rb /scumblr/db/

# Copy database.yml
ADD config/scumblr/database.yml /scumblr/config/

# Copy scumblr config
ADD config/scumblr/scumblr.rb /scumblr/config/initializers/

# Setup db
# RUN /bin/bash -l -c "rake db:create"
# RUN /bin/bash -l -c "rake db:schema:load"
# RUN /bin/bash -l -c "rake db:seed"

# Add nginx config files and ssl cert/key
ADD config/nginx/nginx-sites.conf /etc/nginx/sites-enabled/default
ADD config/nginx/server.crt /etc/nginx/ssl/
ADD config/nginx/server.key /etc/nginx/ssl/

# Add startup script
ADD scripts/start-server.sh /usr/bin/start-server.sh
RUN chmod +x /usr/bin/start-server.sh

# Startup commands
CMD /usr/bin/start-server.sh





