FROM java:7  
WORKDIR /home/root/javahelloworld  
RUN mkdir bin  
COPY HelloWorld.java .  
RUN javac HelloWorld.java  
RUN apt-get install wget  

