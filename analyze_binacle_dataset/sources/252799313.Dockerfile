FROM java:7  
COPY src/HelloWorld.java /home/root/javahelloworld/src/  
WORKDIR /home/root/javahelloworld  
RUN mkdir bin  
RUN javac -d bin src/HelloWorld.java  
ENV FOO bar  
RUN apt-get update  
RUN apt-get install tree  
ENTRYPOINT ["java", "-cp", "bin", "HelloWorld"]  

