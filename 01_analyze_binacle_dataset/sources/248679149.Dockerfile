# Docker Definition for ElasticSearch Curator

FROM python:2.7.8-slim

# Versions >3.5.1 don't support Environment variables: https://github.com/elastic/curator/issues/697
RUN pip install 'elasticsearch-curator==3.5.1'
COPY docker-entrypoint.sh /

ENTRYPOINT [ "/docker-entrypoint.sh" ]
