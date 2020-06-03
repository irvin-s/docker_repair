FROM java:8  
COPY src /home/root/javahelloworld/src  
COPY apt.conf /etc/atp  
RUN mkdir /home/root/javahelloworld/bin  
WORKDIR /home/root/javahelloworld  
  
RUN javac -d bin src/HelloWorld.java  
  
ENTRYPOINT ["java", "-cp", "bin", "HelloWorld"]  

