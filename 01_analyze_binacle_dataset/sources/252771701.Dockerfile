FROM elasticsearch:2.4  
RUN bin/plugin install cloud-aws -b \  
&& bin/plugin install lmenezes/elasticsearch-kopf  
  
ADD elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml  
ADD logging.yml /usr/share/elasticsearch/config/logging.yml  

