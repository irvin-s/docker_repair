FROM docker.elastic.co/elasticsearch/elasticsearch:5.4.2  
  
RUN elasticsearch-plugin install --batch repository-s3  
  
COPY es-docker bin/es-docker  
  
USER root  
RUN chown elasticsearch:elasticsearch \  
bin/es-docker && \  
chmod 0750 bin/es-docker  
  
USER elasticsearch  
CMD ["/bin/bash", "bin/es-docker"]  
  
EXPOSE 9200 9300

