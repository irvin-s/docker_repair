FROM solr:6.6.1-alpine
MAINTAINER codefordc

ENV SOLR_CORE ckan

# Create Directories
RUN mkdir -p /opt/solr/server/solr/$SOLR_CORE/conf
RUN mkdir -p /opt/solr/server/solr/$SOLR_CORE/data


ADD ./solrconfig.xml \
./schema.xml \
./currency.xml \
./synonyms.txt \
./stopwords.txt \
./protwords.txt \
./elevate.xml \
/opt/solr/server/solr/$SOLR_CORE/conf/

# Create Core.properties
RUN echo name=$SOLR_CORE > /opt/solr/server/solr/$SOLR_CORE/core.properties