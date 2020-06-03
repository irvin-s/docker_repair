FROM docker.elastic.co/elasticsearch/elasticsearch:5.5.1  
  
ENV http.host 0.0.0.0  
ENV transport.host 127.0.0.1  
  
RUN rm -rf plugins/x-pack  

