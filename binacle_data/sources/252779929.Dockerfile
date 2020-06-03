FROM java:7  
COPY src /home/root/javahello/src  
WORKDIR /home/root/javahello  
RUN mkdir bin && javac -d bin src/HelloWorld.java  
  
ENTRYPOINT ["java", "-cp", "bin", "HelloWorld"]  
  

