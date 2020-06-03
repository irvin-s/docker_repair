FROM ruby:2.5.1 as builder

# Necessary for bundler to properly install some gems
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# add nodejs and yarn dependencies for the frontend
RUN curl -sL https://deb.nodesource.com/setup_9.x | bash - && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN gem install bundler

RUN apt-get update -qq && apt-get upgrade -y && \
  apt-get install -y build-essential libpq-dev mysql-client nodejs libreoffice imagemagick unzip ghostscript yarn

# install clamav for antivirus
# fetch clamav local database
RUN apt-get install -y clamav-freshclam clamav-daemon libclamav-dev
RUN mkdir -p /var/lib/clamav && \
  wget -O /var/lib/clamav/main.cvd http://database.clamav.net/main.cvd && \
  wget -O /var/lib/clamav/daily.cvd http://database.clamav.net/daily.cvd && \
  wget -O /var/lib/clamav/bytecode.cvd http://database.clamav.net/bytecode.cvd && \
  chown clamav:clamav /var/lib/clamav/*.cvd

RUN mkdir -p /opt/fits && \
  curl -fSL -o /opt/fits-1.0.5.zip http://projects.iq.harvard.edu/files/fits/files/fits-1.0.5.zip && \
  cd /opt && unzip fits-1.0.5.zip && chmod +X fits-1.0.5/fits.sh

RUN mkdir /data
WORKDIR /data

ADD Gemfile /data/Gemfile
ADD Gemfile.lock /data/Gemfile.lock
RUN mkdir /data/build

ARG RAILS_ENV=development
ENV RAILS_ENV=${RAILS_ENV}

ADD ./build/install_gems.sh /data/build
RUN ./build/install_gems.sh

ADD . /data

FROM builder

RUN if [ "${RAILS_ENV}" = "production" ]; then \
  echo "Precompiling assets with $RAILS_ENV environment"; \
  RAILS_ENV=$RAILS_ENV SECRET_KEY_BASE=temporary bundle exec rails assets:precompile; \
  cp public/assets/404-*.html public/404.html; \
  cp public/assets/500-*.html public/500.html; \
  fi
