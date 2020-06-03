FROM appiriodevops/ap-sample:base  
MAINTAINER tumapathy@appirio.com  
  
COPY target/ap-sample-microservice-1.0.0-SNAPSHOT.jar /data/service.jar  
COPY target/sample-app.yml /data/config.yml  
  
CMD java -jar /data/service.jar server /data/config.yml  
  
EXPOSE 8080 8081  

