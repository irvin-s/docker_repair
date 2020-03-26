FROM elasticsearch:1.4.4

ADD https://github.com/kelseyhightower/confd/releases/download/v0.10.0/confd-0.10.0-linux-amd64 /usr/local/bin/confd
RUN chmod u+x /usr/local/bin/conf d&& \
  mkdir -p /etc/confd/conf.d && \
  mkdir -p /etc/confd/templates

# multi instance version
ADD start.sh /start.sh

ADD elasticsearch.toml /etc/confd/conf.d/elasticsearch.toml
ADD elasticsearch.yml.tmpl /etc/confd/templates/elasticsearch.yml.tmpl

# single instance version
ADD elasticsearch.yml /data/elasticsearch.yml

# single instance version
CMD /start.sh

