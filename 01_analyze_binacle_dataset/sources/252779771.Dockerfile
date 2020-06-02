FROM concordconsortium/solr:5.3  
ENV APP_HOME /opt/solr/rigse-solr-docker  
RUN mkdir $APP_HOME  
WORKDIR $APP_HOME  
  
ADD . $APP_HOME  
ADD notify-portal.sh /docker-entrypoint-initdb.d/  
  
CMD $APP_HOME/start-solr.sh  

