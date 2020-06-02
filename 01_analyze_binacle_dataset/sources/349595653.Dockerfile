FROM airhacks/java

MAINTAINER Sergio Morales "sdmoralesma@gmail.com"

# add jar
ADD unix/target/unix-1.0-jar-with-dependencies.jar /opt/java/

#
CMD ["sh", "-c", "java", "-jar", "/opt/java/unix-1.0-jar-with-dependencies.jar"]
