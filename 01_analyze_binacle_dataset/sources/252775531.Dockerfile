FROM java:7  
COPY src /home/root/javahelloworld/src  
  
WORKDIR /home/root/javahelloworld/  
  
RUN javac src/HelloWorld.java  
  
ENTRYPOINT ["java", "-cp", "bin", "HelloWorld"]  
  

