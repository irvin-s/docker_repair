FROM seapy/rails-nginx-unicorn-pro:v1.0-ruby2.1.2-nginx1.6.0
MAINTAINER seapy(iamseapy@gmail.com)

# Add here your preinstall lib(e.g. imagemagick, mysql lib, pg lib, ssh config)
## Install imagemagick
RUN apt-get update
RUN apt-get -qq -y install libmagickwand-dev imagemagick
## Install for mysql gem
RUN apt-get install -qq -y mysql-server mysql-client libmysqlclient-dev
## Install for Webshots
RUN apt-get install libssl0.9.8 -y
RUN apt-get install ttf-unfonts-core -y

#(required) Install Rails App
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install --without development test
ADD . /app

# Overwrite unicorn
ADD config/unicorn.rb /app/config/unicorn.rb

#(required) nginx port number
EXPOSE 80
