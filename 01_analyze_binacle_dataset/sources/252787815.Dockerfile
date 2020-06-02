FROM elasticsearch:5-alpine  
  
RUN apk add --no-cache curl && \  
rm -rf /var/cache/apk/*  
  
RUN { \  
echo 'indices.breaker.fielddata.limit: 90%'; \  
echo 'indices.breaker.request.limit: 90%'; \  
echo 'http.max_content_length: 1gb'; \  
} | tee -a /usr/share/elasticsearch/config/elasticsearch.yml  
  
COPY docker-healthcheck /usr/local/bin/  
  
HEALTHCHECK CMD ["docker-healthcheck"]  

