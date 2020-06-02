FROM java:7  
WORKDIR /home/root/javahelloworld  
RUN mkdir bin  
#COPY HelloWorld.java /  
COPY src /home/root/javahelloworld/src  
#RUN javac HelloWorld.java  
RUN javac -d bin src/HelloWorld.java  
  
#ENTRYPOINT ["java", "HelloWorld"]  
ENTRYPOINT ["java", "-cp", "bin", "HelloWorld"]  
  

