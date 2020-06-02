FROM logstash  
  
RUN mkdir -p /config-dir  
RUN /opt/logstash/bin/plugin install logstash-input-beats \  
&& /opt/logstash/bin/plugin install logstash-filter-json_encode  
ADD ./config-dir /config-dir  
COPY ./init_app.sh /root/init_app.sh  
  
ENTRYPOINT ["/root/init_app.sh"]  

