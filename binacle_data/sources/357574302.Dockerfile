FROM java
MAINTAINER Jon Schneider "joschneider@netflix.com"
VOLUME /tmp
ADD build/libs/sample-eureka.jar /app.jar
RUN bash -c 'touch /app.jar'
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app.jar"]
