FROM elasticsearch:2.3.3  
# Original author is Thomas Zoratto (https://github.com/tzoratto)  
MAINTAINER Bertrand Martel <bmartel.fr@gmail.com>  
  
# The shield plugin configuration must be in ES_HOME/config  
RUN cat config/elasticsearch.yml > /etc/elasticsearch/elasticsearch.yml  
RUN rm -rf config  
RUN ln -s /etc/elasticsearch/ config  
  
# Install plugins  
RUN plugin install license  
RUN plugin install shield  
  
# Add specific role  
COPY roles.yml /usr/share/elasticsearch/config/shield/  
  
ENV LOGSTASH_USER_NAME logstash  
ENV LOGSTASH_PWD logstash  
ENV KIBANA_ADMIN_USER_NAME kibana4-server  
ENV KIBANA_PWD kibana  
ENV KIBANA_USER_NAME kibana  
ENV KIBANA_USER_PWD kibana  
  
COPY es-entrypoint.sh /  
ENTRYPOINT ["/es-entrypoint.sh"]  
CMD ["elasticsearch"]  

