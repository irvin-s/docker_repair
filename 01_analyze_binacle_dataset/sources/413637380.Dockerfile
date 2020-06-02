FROM asuforce/puppetserver

RUN apt-get update -qq \
  && apt-get install -qq git

WORKDIR /etc/puppetlabs/code/environments
RUN cp -r production development
ADD . development

WORKDIR /etc/puppetlabs/code/environments/development
RUN bundle install --path vendor/bundle
RUN bundle exec librarian-puppet install
