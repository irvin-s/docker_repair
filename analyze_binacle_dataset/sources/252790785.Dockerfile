FROM bde2020/spark-java-template:1.6.2-hadoop2.6  
MAINTAINER Casper Van Gheluwe <caspervg@gmail.com>  
  
ENV SPARK_APPLICATION_MAIN_CLASS net.caspervg.aggr.master.AggrMasterMain  
ENV SPARK_APPLICATION_JAR_NAME aggr-1.0.1-with-dependencies  
  
ENV APP_ARGS_SERVICE=http://database:8890/sparql/  
  
ADD run/ run  
  
RUN chmod -R +x run/  
  
CMD ["/bin/bash", "run/master.sh"]

