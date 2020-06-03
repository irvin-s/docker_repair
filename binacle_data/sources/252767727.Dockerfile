FROM quay.io/pires/docker-elasticsearch-kubernetes:5.1.1  
RUN /elasticsearch/bin/elasticsearch-plugin install analysis-icu  
RUN /elasticsearch/bin/elasticsearch-plugin install -s repository-gcs  
RUN /elasticsearch/bin/elasticsearch-plugin install -s x-pack  
COPY run.sh /  
RUN chmod 755 /run.sh  

