FROM docker.elastic.co/logstash/logstash:6.2.3  
RUN rm -f /usr/share/logstash/pipeline/logstash.conf  
ADD pipeline/ /usr/share/logstash/pipeline/  
ENV ELASTICSEARCH_HOST="elasticsearch" \  
ELASTICSEARCH_PORT="9200" \  
ELASTICSEARCH_USER="elastic" \  
ELASTICSEARCH_PASSWORD="changeme" \  
ELASTICSEARCH_INDEX="logstash-%{+YYYY.MM.dd}" \  
REDIS_HOST="redis" \  
REDIS_PORT=6379 \  
REDIS_PASSWORD="password" \  
REDIS_DB=0 \  
REDIS_KEY="logs" \  
REDIS_DATA_TYPE="list" \  
REDIS_CODEC="json"  
RUN logstash-plugin install logstash-input-redis  
  

