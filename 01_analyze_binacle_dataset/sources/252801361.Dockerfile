FROM barnybug/elasticsearch:1.4.4  
RUN elasticsearch/bin/plugin -i elasticsearch/marvel/latest  
ADD elasticsearch.yml /elasticsearch/config/elasticsearch.yml  

