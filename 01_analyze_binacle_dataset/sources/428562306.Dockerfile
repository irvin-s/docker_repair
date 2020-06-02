FROM mikz/hosting:precise
MAINTAINER Michal Cichra <michal.cichra@gmail.com>

RUN apt-add-repository -y ppa:brightbox/ruby-ng \
 && apt-get -q -y update \
 && apt-get -q -y install ruby1.9.3 rubygems \
 && apt-cleanup

RUN gem install passenger bundler

ADD supervisor.conf /etc/supervisor/conf.d/passenger.conf

ENV RAILS_ENV production

WORKDIR /www

ONBUILD ADD Gemfile /www/
ONBUILD ADD Gemfile.lock /www/
ONBUILD RUN bundle install --deployment --without test development --jobs `$NUM_CPU`

ONBUILD ADD . /www

ONBUILD ADD config/docker/ /www/config

ONBUILD CMD ["supervisord"]

EXPOSE 3000
