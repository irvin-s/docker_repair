ARG CACHE_TAG=latest  
ARG NS  
  
FROM ${NS}/ktadvance-h2-empty-sq:${CACHE_TAG}  
  
#install PG command line tools  
RUN apk --update add postgresql-client  
  
COPY wait-for-it.sh $SONARQUBE_HOME/bin  
RUN chmod +x $SONARQUBE_HOME/bin/wait-for-it.sh  
  
#WORKDIR $PLUGINS_DIR  
#RUN pwd  
#RUN ls -l  
WORKDIR $SONARQUBE_HOME  
  
CMD ["./bin/wait-for-it.sh", "db", "./bin/run.sh", ""]  

