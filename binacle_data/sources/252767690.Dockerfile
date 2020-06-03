FROM acherlyonok/collectd:latest  
  
RUN apt -y install git  
  
ADD 20-elasticsearch.conf.tpl /etc/collectd/conf.d/20-elasticsearch.conf.tpl  
  
# install plugins  
ADD plugins.sh /etc/collectd/plugins.sh  
RUN /etc/collectd/plugins.sh  
  
ADD start_container /usr/bin/start_container  
RUN chmod +x /usr/bin/start_container  
CMD start_container  

