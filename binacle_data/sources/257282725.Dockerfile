FROM fluent/fluentd:latest

WORKDIR /home/fluent
ENV PATH /home/fluent/.gem/ruby/2.2.0/bin:$PATH
RUN gem install fluent-plugin-elasticsearch

USER root
COPY fluent.conf /fluentd/etc

EXPOSE 24284

USER fluent
VOLUME /fluentd/log
CMD fluentd -c /fluentd/etc/$FLUENTD_CONF -p /fluentd/plugins $FLUENTD_OPT
