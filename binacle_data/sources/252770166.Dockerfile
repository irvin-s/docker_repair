FROM java:7  
COPY src /latihan/javahelloworld/src  
  
WORKDIR /latihan/javahelloworld  
  
RUN mkdir bin  
RUN javac -d bin src/HelloWorld.java  
  
ENTRYPOINT ["java", "-cp", "bin", "HelloWorld"]  

