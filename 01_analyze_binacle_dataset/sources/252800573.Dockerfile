FROM openjdk:8  
VOLUME /tmp  
ADD RestTest.jar RestTest.jar  
EXPOSE 8080  
ENTRYPOINT ["java", "-jar","RestTest.jar"]

