FROM java:8  
COPY src/ /home/root/javahelloworld/src  
WORKDIR /home/root/javahelloworld/  
RUN mkdir bin  
RUN javac -d bin src/HelloWorld.java  
ENV FOO bar  
ENV HOME /var/jboss/  
ENV BUILD AUTOMATED  
  
ENTRYPOINT ["java", "-cp", "bin", "HelloWorld"]  
  

