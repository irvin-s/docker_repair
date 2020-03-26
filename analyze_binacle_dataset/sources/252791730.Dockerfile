FROM jeanblanchard/java:jdk-8  
ADD assets/ /opt/spring-initializd  
  
RUN /opt/spring-initializd/seed.sh  

