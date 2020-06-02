FROM java:7  
COPY src /home/root/javahelloworld/src  
WORKDIR /home/root/javahelloworld  
RUN mkdir bin  
RUN javac -d bin src/HelloWorld.java  
RUN echo hello  
ENTRYPOINT ["java", "-cp", "bin", "HelloWorld"]  
ENV FOO bar  
MAINTAINER i built this :) thanks  

