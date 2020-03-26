FROM java:8  
WORKDIR /axonbank  
  
#Building an app  
ADD pom.xml /axonbank/pom.xml  
ADD src /axonbank/src  
  
RUN apt-get update -y && apt-get install maven -y  
RUN mvn install  
  
EXPOSE 8080  
ENTRYPOINT ["java", "-jar", "target/axonbank-0.0.1-SNAPSHOT.jar"]

