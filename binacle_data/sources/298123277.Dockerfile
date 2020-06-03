FROM docker.elastic.co/elasticsearch/elasticsearch:5.2.2

MAINTAINER Kumud Kumar Srivatsava Tirupati <kumud.t@nestaway.com>

ADD elasticsearch.yml /usr/share/elasticsearch/config/
ADD log4j2.properties /usr/share/elasticsearch/config/

USER root
RUN chown elasticsearch:elasticsearch config/elasticsearch.yml
RUN chown elasticsearch:elasticsearch config/log4j2.properties
RUN chown -R elasticsearch:elasticsearch config
RUN chown -R elasticsearch:elasticsearch data
RUN chown -R elasticsearch:elasticsearch logs

USER elasticsearch
