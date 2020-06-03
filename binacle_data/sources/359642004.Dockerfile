FROM luxas/java

# Add support for cross-builds
COPY qemu-arm-static /usr/bin/

ENV ELASTICSEARCH_VERSION=2.3.3

RUN apk add --update curl sudo \
  	&& curl -sSL https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/${ELASTICSEARCH_VERSION}/elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz | tar -xz \
  	&& mv /elasticsearch-${ELASTICSEARCH_VERSION} /elasticsearch \
  	&& rm -rf $(find /elasticsearch | egrep "(\.(exe|bat)$|sigar/.*(dll|winnt|x86-linux|solaris|ia64|freebsd|macosx))") \
  	&& apk del curl

# Logging configuration and a config for installing plugins
COPY logging.yml  /elasticsearch/config/
COPY install-plugin.yml /elasticsearch/config/elasticsearch.yml

# Install the Kubernetes plugin
RUN /elasticsearch/bin/plugin install io.fabric8/elasticsearch-cloud-kubernetes/${ELASTICSEARCH_VERSION}

# Add the real config back
COPY elasticsearch.yml /elasticsearch/config/elasticsearch.yml
COPY run.sh /

CMD ["/run.sh"]
