FROM java:8  
COPY HelloWorld.java /  
RUN javac HelloWorld.java  
  
ENTRYPOINT ["java", "HelloWorld"]  
  

