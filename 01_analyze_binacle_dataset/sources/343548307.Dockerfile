# Heroku-16 is based on Ubuntu 16.4
# Debian Stretch is the upstream of Ubuntu 16.4
FROM ruby:2.6.3-stretch
MAINTAINER Darin London <darin.london@duke.edu>

# NodeJS and npm
## Heroku-16 uses node 10.14. This installs node 10.15
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt-get install -y nodejs

#Postgresql client
RUN /usr/bin/apt-get update && /usr/bin/apt-get install -y postgresql libpq-dev

#GraphViz for Rails ERD
RUN /usr/bin/apt-get install -y graphviz

#RubyGems system update
RUN ["gem", "update", "--system", "2.7.6"]

#miscellaneous
RUN ["mkdir","-p","/var/www"]
WORKDIR /var/www
RUN git clone https://github.com/Duke-Translational-Bioinformatics/duke-data-service.git app
WORKDIR /var/www/app
RUN git checkout develop
ADD Gemfile /var/www/app/Gemfile
ADD Gemfile.lock /var/www/app/Gemfile.lock
RUN ["bundle", "config", "build.nokogiri", "--use-system-libraries"]
RUN ["bundle", "install", "--jobs=4"]

# run the app by defualt
EXPOSE 3000
CMD ["puma"]
