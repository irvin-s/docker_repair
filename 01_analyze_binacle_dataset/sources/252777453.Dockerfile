#  
# Java Dockerfile  
#  
#  
# https://github.com/chadneal/javadocker  
#  
# Pull base image. Ubuntu latest with Java 7 JDK installed  
FROM chadneal/java7  
  
WORKDIR /apps  
  
# Sample java test application  
# test with URI:8080/test  
# returns "42"  
RUN wget http://www.chadneal.com/grizz-1.0-SNAPSHOT.jar  
EXPOSE 8080  
CMD ["-jar", "/apps/grizz-1.0-SNAPSHOT.jar"]  
ENTRYPOINT ["/usr/bin/java"]  
  

