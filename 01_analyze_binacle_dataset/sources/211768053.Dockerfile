FROM anapsix/alpine-java
VOLUME ["/etc/raptor"]
COPY target/raptor-action-1.0-exec.jar /raptor.jar
CMD ["java","-jar","/raptor.jar"]
