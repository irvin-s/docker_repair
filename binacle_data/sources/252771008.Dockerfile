FROM java:7  
MAINTAINER Alvaro Gutierrez <alvaro.gutierrez-cachon@adp.com>  
  
COPY HelloWorld.java /  
  
RUN javac HelloWorld.java  
  
ENTRYPOINT ["java", "HelloWorld"]

