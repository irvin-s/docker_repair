FROM maven:3.5-jdk-8-slim as maven  
  
COPY pom.xml /workdir/  
COPY src /workdir/src/  
WORKDIR /workdir  
RUN mvn -Dmaven.repo.local=repo.local package  
  
FROM jetty:9.4.7-jre8 as jetty  
COPY \--from=maven /workdir/target/*war $JETTY_BASE/webapps  
COPY configuration $JETTY_BASE/resources/  
COPY entry.sh $JETTY_BASE  
  
ENV IMAGE_HOME /var/image_home  
VOLUME $IMAGE_HOME  
  
EXPOSE 8080  
ENTRYPOINT ["sh", "-c", "cd $JETTY_BASE; ./entry.sh"]  

