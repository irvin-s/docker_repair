FROM dockerfile/java:oracle-java8
MAINTAINER plopez@bmj.com
EXPOSE 8090
COPY target/sample-spring-boot-rest-0.0.1-SNAPSHOT.jar /data/sample-spring-boot-rest-0.0.1-SNAPSHOT.jar
COPY config/* /data/config/
CMD java -jar sample-spring-boot-rest-0.0.1-SNAPSHOT.jar
