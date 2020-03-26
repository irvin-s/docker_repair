FROM maven:3-alpine  
  
# Creating Application Source Code Directory  
RUN mkdir -p /usr/src/app  
  
# Setting Home Directory for containers  
WORKDIR /usr/src/app  
  
# Copying src code to Container  
ADD . /usr/src/app  
  
# Building From Source Code  
RUN mvn clean package  
  
# Exposing Port  
EXPOSE 8083  
# Running Kotlin Application  
CMD ["java", "-jar", "target/SOSKit-Backend-0.1.0-jar-with-dependencies.jar"]

