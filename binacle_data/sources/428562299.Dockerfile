FROM mikz/hosting:precise
MAINTAINER Michal Cichra <michal.cichra@gmail.com>

RUN gpg --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7 \
 && gpg --armor --export 561F9B9CAC40B2F7 | apt-key add -  \
 && echo "deb https://oss-binaries.phusionpassenger.com/apt/passenger precise main"  > /etc/apt/sources.list.d/passenger.list \
 && apt-get update -q -y

RUN apt-get -q -y install git imagemagick libmagickwand-dev
RUN apt-get -y --force-yes install ruby-dev passenger rubygems

ADD supervisor.conf /etc/supervisor/conf.d/passenger.conf

RUN gem install bundler

WORKDIR /www

ONBUILD ADD Gemfile /www/
ONBUILD ADD Gemfile.lock /www/
ONBUILD RUN bundle install --deployment --without test development --jobs `$NUM_CPU`
ONBUILD ADD . /www
ONBUILD ADD config/docker/ /www/config
ONBUILD ENV RAILS_ENV production
ONBUILD CMD ["supervisord"]
ONBUILD EXPOSE 3000

#VOLUME ["/www/public/system"]
