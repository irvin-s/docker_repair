FROM openjdk:8  
ENV FOO bar  
WORKDIR /home/docker/javahelloworld  
COPY src /home/docker/javahelloworld/src  
RUN mkdir bin  
RUN javac -d bin src/HelloWorld.java  
RUN echo test  
ENTRYPOINT ["java", "-cp", "bin", "HelloWorld"]  
  

