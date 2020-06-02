FROM java:8  
COPY src /home/root/javahelloworld/src  
  
WORKDIR /home/root/javahelloworld  
  
RUN mkdir bin  
RUN javac -d bin src/HelloWorld.java  
  
ENV FOO bar  
  
RUN apt-get install wget  
  
ENTRYPOINT ["java", "-cp", "bin", "HelloWorld"]  

