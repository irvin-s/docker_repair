# Logstash  
FROM digitalwonderland/base:latest  
  
Add ./src /  
  
RUN chmod +x /usr/local/sbin/start.sh  
  
RUN rpm --import http://packages.elasticsearch.org/GPG-KEY-elasticsearch \  
&& yum install -y logstash openssl \  
&& yum clean all  
  
RUN mkdir /mnt/logstash-forwarder \  
&& chown -R logstash:logstash /mnt/logstash-forwarder  
  
EXPOSE 5043  
VOLUME ["/etc/logstash", "/mnt/logstash-forwarder"]  
  
ENTRYPOINT ["/usr/local/sbin/start.sh"]  

