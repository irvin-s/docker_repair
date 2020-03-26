FROM openjdk:8-jdk-alpine
EXPOSE 8081 8443
RUN mkdir -p /opt
COPY reactive-customer-service.jar /opt
RUN sh -c 'touch reactive-customer-service.jar'  
ENTRYPOINT ["java", "-Dspring.data.mongodb.uri=mongodb://mongodb/customers","-Djava.security.egd=file:/dev/./urandom","-jar","/opt/reactive-customer-service.jar"]  
