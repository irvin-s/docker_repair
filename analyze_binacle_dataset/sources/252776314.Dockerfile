FROM java:7  
ENV FOO bar  
  
COPY src/HelloWorld.java /home/root/javahelloworld/src/  
WORKDIR /home/root/javahelloworld  
RUN mkdir bin  
RUN javac -d bin src/HelloWorld.java  
RUN mkdir /atestdir  
ENTRYPOINT ["java", "-cp", "bin", "HelloWorld"]  

