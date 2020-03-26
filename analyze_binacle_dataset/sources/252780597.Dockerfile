FROM java:8-jdk  
  
# Install maven and make sure jdk is not replaced by older maven deps  
RUN apt-get update  
RUN apt-get --no-install-recommends install -y maven  
  
WORKDIR /code  
  
# Prepare by downloading dependencies  
ADD pom.xml /code/pom.xml  
RUN ["mvn", "dependency:resolve"]  
RUN ["mvn", "verify"]  
  
# Adding source, compile and package into a fat jar  
ADD src /code/src  
RUN ["mvn", "package"]  
  
EXPOSE 4567  
ENTRYPOINT ["java", "-jar", "target/currentweather-jar-with-dependencies.jar"]  

