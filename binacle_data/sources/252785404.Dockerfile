FROM java:7  
COPY src /home/root/java/src  
  
WORKDIR /home/root/java  
  
RUN mkdir bin  
  
RUN javac -d bin src/Hello.java  
  
RUN apt-get install -y wget  
  
ENTRYPOINT ["java", "-cp", "bin", "Hello"]  

