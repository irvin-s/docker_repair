#
# Ubuntu Dockerfile
#
# https://github.com/dockerfile/ubuntu
#

# Pull base image.
FROM rounds/10m-elastic-search

# Install Elastic Search plugins.
RUN \
  /usr/share/elasticsearch/bin/plugin --install royrusso/elasticsearch-HQ && \
  /usr/share/elasticsearch/bin/plugin --install mobz/elasticsearch-head && \
  /usr/share/elasticsearch/bin/plugin --install lmenezes/elasticsearch-kopf && \
  /usr/share/elasticsearch/bin/plugin --url https://github.com/NLPchina/elasticsearch-sql/releases/download/1.3.5/elasticsearch-sql-1.3.5.zip --install sql && \
  /usr/share/elasticsearch/bin/plugin --install elasticsearch/elasticsearch-cloud-gce/2.5.0
