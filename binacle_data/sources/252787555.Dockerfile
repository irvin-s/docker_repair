  
FROM maven:3.5  
ADD ./ /octo-user-service  
EXPOSE 8089  
RUN cd octo-user-service && mvn clean package  
  
WORKDIR octo-user-service  
CMD java -jar ./target/octo-user-service-0.0.1-SNAPSHOT.jar  

