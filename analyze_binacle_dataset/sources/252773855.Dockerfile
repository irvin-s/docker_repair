FROM ubuntu:latest  
COPY . repo/  
WORKDIR repo  
RUN apt-get update; apt-get -y install maven; apt-get -y install openjdk-8-jdk  
RUN mvn -DskipTests package  
WORKDIR /usr/src/app  
RUN cp /repo/target/*.jar ./app.jar  
  
RUN chown -R ${SERVICE_USER}:${SERVICE_GROUP} ./app.jar  
  
USER ${SERVICE_USER}  
  
ENV JAVA_OPTS "-Djava.security.egd=file:/dev/urandom"  
ENTRYPOINT ["/usr/bin/java","-jar","./app.jar", "--port=80"]  

