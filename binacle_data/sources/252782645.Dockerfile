FROM logstash:2.4  
ENV ES_HOSTS "http://localhost:9200"  
COPY docker/logstash.conf /etc/  
COPY docker/entrypoint.sh /entrypoint.sh  
  
RUN chmod a+x /entrypoint.sh  
  
CMD ["logstash", "-f", "/etc/logstash.conf"]  
ENTRYPOINT ["/entrypoint.sh"]  

