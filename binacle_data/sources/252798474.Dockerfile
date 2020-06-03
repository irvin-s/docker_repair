FROM java:7  
COPY HelloWorld.java /  
RUN javac HelloWorld.java  
ENTRYPOINT ["java", "HelloWorld"]  

