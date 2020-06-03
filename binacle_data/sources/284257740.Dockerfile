FROM solr:7.7.0
# FROM solr:7.7.0-alpine

USER root
RUN mkdir /var/solr
RUN chown -R solr:solr /var/solr
USER solr
