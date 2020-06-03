FROM fluent/fluentd:v0.12.28

#add ElasticSearch plugins
USER root
RUN apk --no-cache --update add \
      sudo \
      build-base \
      ruby-dev \
      geoip-dev \
      curl \
      ca-certificates\
  && sudo -u fluent gem install \
      fluent-plugin-parser \
      fluent-plugin-fields-parser \
      fluent-plugin-mutate_filter \
      fluent-plugin-geoip \
      fluent-plugin-elasticsearch \
  && rm -rf /home/fluent/.gem/ruby/2.3.0/cache/*.gem \
  && sudo -u fluent gem source -c \
  && apk del sudo build-base ruby-dev \
  && rm -rf /var/cache/apk/*

#update Geoip database
RUN wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz \
  && gunzip GeoLiteCity.dat.gz \
  && mkdir -p /usr/share/GeoIP/ \
  && mv -f GeoLiteCity.dat /usr/share/GeoIP/

#add dockerize for orchestration
#use Dockerize to syncronize startup...
ENV DOCKERIZE_VERSION v0.2.0
RUN curl -Lo dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz
#add index template for indices with logstash-* prefix...
COPY elasticsearch-template.json /usr/share/elasticsearch-template.json

USER fluent

#onbuild: cp fluent.conf,plugins/ -> /fluentd/etc,/fluentd/plugins/
COPY fluent.conf /fluentd/etc/
COPY plugins /fluentd/plugins/
