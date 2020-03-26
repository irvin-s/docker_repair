FROM java:7  
COPY src /home/root/src/  
WORKDIR /home/root  
RUN mkdir bin  
RUN javac -d bin src/HelloWorld.java  
ENTRYPOINT ["echo",,"HelloWorld"]  
  

