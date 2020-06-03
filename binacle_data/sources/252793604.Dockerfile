FROM java:8  
MAINTAINER Chinmay Tripathi  
WORKDIR /home/root/javahelloworld  
COPY src /home/root/javahelloworld/src  
RUN mkdir bin  
RUN javac -d bin src/HelloWorld.java  
ENTRYPOINT ["java", "-cp", "bin", "HelloWorld"]  
ENV FOO bar  
RUN apt-get install wget  
  

