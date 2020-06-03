FROM docker.elastic.co/elasticsearch/elasticsearch:6.1.1

MAINTAINER https://github.com/cesargomezvela

# Set environment variables defaults
ENV ES_JAVA_OPTS "-Xms512m -Xmx512m"
ENV CLUSTER_NAME elasticsearch-default
ENV NODE_MASTER true
ENV NODE_DATA true
ENV NODE_INGEST true
ENV HTTP_ENABLE true
ENV NETWORK_HOST _site_
ENV HTTP_CORS_ENABLE true
ENV HTTP_CORS_ALLOW_ORIGIN *
ENV NUMBER_OF_MASTERS 1
ENV MAX_LOCAL_STORAGE_NODES 1
ENV MEMORY_LOCK true
ENV LICENSE basic

# kubernetes
ENV DISCOVERY_SERVICE elasticsearch-discovery

# Copy configuration
COPY config /usr/share/elasticsearch/config

# Copy run script
COPY run.sh /

CMD ["/run.sh"]