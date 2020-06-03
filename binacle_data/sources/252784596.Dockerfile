FROM maven:3-jdk-8-alpine  
  
COPY . /usr/src/app  
WORKDIR /usr/src/app  
RUN mvn compile assembly:single  
  
EXPOSE 9869  
ENTRYPOINT ["java", "-jar", "target/intertalk.jar"]

