FROM asuforce/puppetserver

RUN apt-get update -qq \
  && apt-get install -qq git

ENV PATH $PATH:/opt/puppetlabs/puppet/bin/

WORKDIR /etc/puppetlabs/code/environments
RUN cp -r production development
ADD . development

WORKDIR /etc/puppetlabs/code/environments/development
RUN bundle install --path vendor/bundle
RUN bundle exec librarian-puppet install --path vendor/modules
