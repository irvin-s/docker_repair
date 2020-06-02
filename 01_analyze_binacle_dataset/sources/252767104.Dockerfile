FROM java:7  
ENV FOO bar  
ENV HOME /home/root  
WORKDIR /home/root/javahelloworld  
COPY src /home/root/javahelloworld/src  
RUN mkdir bin  
RUN javac -d bin src/HelloWorld.java  
ENTRYPOINT ["java", "-cp", "bin", "HelloWorld"]  

