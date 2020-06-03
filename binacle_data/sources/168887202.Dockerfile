FROM socrata/runit
MAINTAINER Socrata <sysadmin@socrata.com>

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update && \
  DEBIAN_FRONTEND=noninteractive apt-get --force-yes -fuy install software-properties-common && \
  DEBIAN_FRONTEND=noninteractive add-apt-repository -y ppa:brightbox/ruby-ng && \
  DEBIAN_FRONTEND=noninteractive apt-get -y update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y ruby2.2 ruby2.2-dev && \
  DEBIAN_FRONTEND=noninteractive apt-get purge -y --auto-remove software-properties-common && \
  rm -rf /var/lib/apt/lists/*

# skip installing gem documentation
RUN echo 'gem: --no-rdoc --no-ri --no-document' >> "/etc/gemrc" && \
  gem install bundler -v 1.17 --no-document

# LABEL must be last for proper base image discoverability
LABEL repository.socrata/runit-ruby2.2=""
