FROM elasticsearch:2.0  
RUN /usr/share/elasticsearch/bin/plugin install mobz/elasticsearch-head  
RUN /usr/share/elasticsearch/bin/plugin install cloud-aws  
  
# Environment variables for elasticsearch configuration.  
ENV CLUSTER_NAME default_cluster_name  
ENV NODE_DATA true  
ENV AWS_ACCESS_KEY None  
ENV AWS_SECRET_KEY None  
ENV AWS_REGION None  
ENV SECURITY_GROUP None  
ENV DISCOVERY_ZEN_MINIMUM_MASTER_NODES 5  
ENV HTTP_ENABLED true  
ENV GATEWAY_RECOVER_AFTER_NODES 3  
ENV GATEWAY_EXPECTED_NODES 9  
COPY config/ /usr/share/elasticsearch/config/  

