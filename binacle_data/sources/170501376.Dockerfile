FROM phusion/baseimage:0.9.16
MAINTAINER Open Knowledge

# set UTF-8 locale
RUN locale-gen en_US.UTF-8 && \
    echo 'LANG="en_US.UTF-8"' > /etc/default/locale

RUN apt-get -qq update

# Install Java
RUN DEBIAN_FRONTEND=noninteractive apt-get -qq -y install \
        default-jre-headless \
        wget

# Install Solr
ENV SOLR_HOME /opt/solr/example/solr
ENV SOLR_VERSION 4.10.1
ENV SOLR solr-$SOLR_VERSION
RUN mkdir -p /opt/solr
RUN wget --progress=bar:force https://archive.apache.org/dist/lucene/solr/$SOLR_VERSION/$SOLR.tgz
RUN tar zxf $SOLR.tgz -C /opt/solr --strip-components 1

# Install CKAN Solr core
RUN cp -R $SOLR_HOME/collection1/ $SOLR_HOME/ckan/
RUN echo name=ckan > $SOLR_HOME/ckan/core.properties
ADD schema.xml $SOLR_HOME/ckan/conf/schema.xml
ONBUILD COPY schema.xml $SOLR_HOME/ckan/conf/schema.xml

# Configure runit
ADD ./svc /etc/service/
CMD ["/sbin/my_init"]

VOLUME  ["/opt/solr/example/solr/ckan/conf/","/var/lib/solr/solr"]
EXPOSE 8983

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* $SOLR.tgz

# Disable SSH
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh
