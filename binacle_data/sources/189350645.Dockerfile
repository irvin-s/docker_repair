FROM ruby:2.0.0-p643
MAINTAINER Alex Kurkin <akurkin@stelladot.com>

RUN mkdir /root/.ssh/

COPY id_rsa_rosi /root/.ssh/id_rsa

# Create known_hosts
RUN touch /root/.ssh/known_hosts

# Add bitbucket's known host
RUN ssh-keyscan bitbucket.org >> /root/.ssh/known_hosts
RUN apt-get update && apt-get install -y build-essential nodejs mysql-client runit --no-install-recommends && rm -rf /var/lib/apt/lists/*

# Install consul-template
ENV CT_URL https://github.com/hashicorp/consul-template/releases/download/v0.7.0/consul-template_0.7.0_linux_amd64.tar.gz
RUN curl -L $CT_URL | tar -C /usr/local/bin --strip-components 1 -zxf -

RUN mkdir -p /etc/service/unicorn
RUN mkdir -p /etc/service/consul-template
RUN mkdir -p /etc/service/consumers

COPY unicorn.service /etc/service/unicorn/run
COPY consumers.service /etc/service/consumers/run
COPY consul-template.service /etc/service/consul-template/run

ENV GEM_HOME /web/rubygems/2.0.0-p643
ENV BUNDLE_PATH /web/rubygems/2.0.0-p643
ENV PATH /web/rubygems/2.0.0-p643/bin:$PATH

RUN gem install bundler

RUN mkdir -p /web/service
WORKDIR /web/service

ONBUILD COPY Gemfile Gemfile
ONBUILD COPY Gemfile.lock Gemfile.lock
ONBUILD COPY ./ /web/service/

CMD ["runsvdir", "/etc/service"]%
