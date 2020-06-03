FROM library/elasticsearch:2.4.6-alpine  
  
COPY elasticsearch.yml ./config/elasticsearch.yml  

