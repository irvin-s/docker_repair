FROM socrata/runit
MAINTAINER Socrata <sysadmin@socrata.com>

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update && \
  DEBIAN_FRONTEND=noninteractive apt-get --force-yes -fuy install software-properties-common && \
  DEBIAN_FRONTEND=noninteractive add-apt-repository -y ppa:brightbox/ruby-ng && \
  DEBIAN_FRONTEND=noninteractive apt-get -y update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y ruby2.3 ruby2.3-dev && \
  DEBIAN_FRONTEND=noninteractive apt-get purge -y --auto-remove software-properties-common && \
  rm -rf /var/lib/apt/lists/*

# RUN gem update --system 3.0.2

# skip installing gem documentation
RUN echo 'gem: --no-rdoc --no-ri --no-document' >> "/etc/gemrc" && \
  gem install bundler --no-document -v 1.17

# LABEL must be last for proper base image discoverability
LABEL repository.socrata/runit-ruby2.3=""
