FROM anapsix/alpine-java
VOLUME ["/etc/raptor"]
COPY target/raptor-profile-1.0-exec.jar /raptor.jar
CMD ["java","-jar","/raptor.jar"]
