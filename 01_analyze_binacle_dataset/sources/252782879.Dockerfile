FROM logstash:2.3  
RUN plugin install logstash-output-amazon_es  

