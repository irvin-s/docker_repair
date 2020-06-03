FROM karlstoney/jvm:latest

# Get nodejs repos
RUN curl --silent --location https://rpm.nodesource.com/setup_7.x | bash -

# Install nodejs, currently 7.4.0
RUN yum -y -q install nodejs-7.4.* gcc-c++ make git bzip2 && \
    yum -y -q clean all

# Get Banana
ENV BANANA_VERSION 1.6.12
ENV BANANA_HOME /opt/banana
ENV BANANA_DIST https://github.com/lucidworks/banana/archive/v$BANANA_VERSION.tar.gz
RUN curl --silent -fSL "$BANANA_DIST" -o /tmp/banana.tar.gz && \
    tar -xf /tmp/banana.tar.gz -C /opt/ && \
    rm -f /tmp/banana.tar.gz && \
    mv /opt/banana-* $BANANA_HOME

RUN cd /opt/banana && \
    npm install -q

ENV SOLR_HOST solr
ENV SOLR_PORT 8983
ENV SOLR_DOMAIN solr/

EXPOSE 8000
HEALTHCHECK CMD curl -f http://localhost:8000/ || exit 1
ADD run.sh /usr/local/bin/run.sh
CMD ["/usr/local/bin/run.sh"]
