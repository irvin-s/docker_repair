FROM rossbachp/jre8
MAINTAINER Peter Rossbach <peter.rossbach@bee42.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update && \
    apt-get install -y curl sudo && \
    curl http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add - && \
    echo "deb http://packages.elasticsearch.org/elasticsearch/1.3/debian stable main" >> /etc/apt/sources.list && \
    apt-get -qq update && \
    apt-get install -y elasticsearch

ADD elasticsearch /usr/local/bin/elasticsearch
RUN chmod +x /usr/local/bin/elasticsearch

EXPOSE 9200 9300
VOLUME ["/var/lib/elasticsearch"]
CMD ["/usr/local/bin/elasticsearch"]
