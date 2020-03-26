FROM fluent/fluentd:latest

MAINTAINER Christian Moser <onmomo>

USER fluent

WORKDIR /home/fluent

ENV PATH /home/fluent/.gem/ruby/2.2.0/bin:$PATH

RUN gem install gelf

EXPOSE 24284

CMD fluentd -c /fluentd/etc/$FLUENTD_CONF -p /fluentd/plugins $FLUENTD_OPT
