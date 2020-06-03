FROM asuforce/puppet

RUN apt-get update -qq \
  && apt-get install -qq git

ADD . /etc/puppet

WORKDIR /etc/puppet
RUN bundle install --path vendor/bundle
RUN bundle exec librarian-puppet install
