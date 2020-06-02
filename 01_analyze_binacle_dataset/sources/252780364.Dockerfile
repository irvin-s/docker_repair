FROM java:7  
COPY src /home/root/helloworldjava/src  
WORKDIR /home/root/helloworldjava  
RUN mkdir bin  
RUN javac -d bin src/HelloWorld.java  
RUN apt-get update  
  
ENTRYPOINT ["java", "-cp", "bin", "HelloWorld"]  
  

