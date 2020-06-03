FROM dockerfile/java:oracle-java8  
  
RUN apt-get update  
RUN apt-get install -y maven  
  
WORKDIR /prooof  
  
# Prepare by downloading dependencies  
ADD pom.xml /prooof/pom.xml  
  
RUN ["mvn", "dependency:resolve"]  
RUN ["mvn", "verify"]  
  
ADD src /prooof/src  
RUN ["mvn", "package"]  
  
EXPOSE 4567  
CMD ["java", "-jar", "target/prooof-jar-with-dependencies.jar"]  

