FROM elasticsearch  
  
RUN plugin install mobz/elasticsearch-head  
  
COPY config/elasticsearch.default /etc/default/elasticsearch  
COPY config/elasticsearch.yml /usr/share/elasticsearch/config/  
COPY config/logging.yml /usr/share/elasticsearch/config/  
COPY init_app.sh /root/  
  
ENTRYPOINT ["/root/init_app.sh"]  

