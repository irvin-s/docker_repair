FROM openshift/base-centos7

MAINTAINER Lorenz Bischof <bischof@puzzle.ch>

ENV LOGSTASH_VERSION=2.3.0 \
    ELASTICSEARCH_SERVICE_HOST=elasticsearch

LABEL io.k8s.description="Logstash" \
      io.k8s.display-name="logstash ${LOGSTASH_VERSION}" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="logstash,${LOGSTASH_VERSION},elk"

RUN \
  rpm --rebuilddb && yum clean all && \
  yum install -y tar java-1.8.0-openjdk openssl && \
  cd /opt/app-root && \
  curl -O https://download.elasticsearch.org/logstash/logstash/logstash-${LOGSTASH_VERSION}.tar.gz && \
  tar zxvf logstash-${LOGSTASH_VERSION}.tar.gz -C /opt/app-root --strip-components=1 && \
  rm -f logstash-${LOGSTASH_VERSION}.tar.gz && \
  yum clean all -y

# Copy the S2I scripts to /usr/libexec/s2i, since openshift/base-centos7 image sets io.openshift.s2i.scripts-url label that way, or update that label
COPY ./.s2i/bin/ /usr/libexec/s2i

# Drop the root user and make the content of /opt/app-root owned by user 1001
RUN chown -R 1001:1001 /opt/app-root

# This default user is created in the openshift/base-centos7 image
USER 1001

CMD ["/usr/libexec/s2i/usage"]
