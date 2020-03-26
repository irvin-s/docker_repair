FROM alpine
MAINTAINER Alexis Montagne <alexis.montagne@gmail.com>

RUN apk --update add curl curl-dev ruby-dev build-base ruby ruby-io-console \
  ruby-bundler git libffi-dev && rm -rf /usr/share/man && rm -rf /usr/share/ri \
  && rm -rf /var/cache/apk/*

RUN curl -sL https://github.com/upfluence/etcdenv/releases/download/v0.3.3/etcdenv-linux-amd64-0.3.3 \
  > /usr/bin/etcdenv && \
  curl -sL https://github.com/upfluence/envtmpl/releases/download/v0.0.1/envtmpl-linux-amd64-0.0.1 \
  > /usr/bin/envtmpl && chmod +x /usr/bin/etcdenv && chmod +x /usr/bin/envtmpl

RUN git clone https://github.com/upfluence/sensu /sensu

COPY gemrc /root/.gemrc

WORKDIR /sensu

ENV SENSU_NAMESPACE /environments/sensu

RUN bundle install --without test --without development

RUN curl -sL \
  https://github.com/upfluence/sensu-transport/releases/download/v3.3.0/sensu-transport-3.3.0.gem \
  > /tmp/sensu-transport.gem && gem install --local /tmp/sensu-transport.gem

RUN curl -Ls https://github.com/kelseyhightower/confd/releases/download/v0.6.3/confd-0.6.3-linux-amd64 \
  > /usr/bin/confd

RUN chmod +x /usr/bin/confd
RUN mkdir -p /etc/confd/{conf.d,templates} /etc/sensu/conf.d

COPY conf.d/checks.toml /etc/confd/conf.d/checks.toml
COPY templates/checks.tmpl /etc/confd/templates/checks.tmpl
