FROM maven:3-jdk-8  
RUN mkdir -p /usr/src/app  
  
WORKDIR /usr/src/app  
  
# Prepare by downloading dependencies  
ADD pom.xml /usr/src/app  
RUN ["mvn", "dependency:resolve"]  
RUN ["mvn", "verify"]  
  
# Adding source, compile and package into a fat jar  
ADD src /usr/src/app/src  
RUN ["mvn", "package"]  
  
EXPOSE 8090  
CMD ["java", "-jar", "target/tradeInjectorUI.jar"]  
  

