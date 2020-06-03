FROM java:7  
ENV FOO bar  
RUN apt-get update  
#RUN apt-get install -y tomcat  
COPY src /home/root/javahelloworld/src  
  
WORKDIR /home/root/javahelloworld  
RUN mkdir bin  
RUN javac -d bin src/HelloWorld.java  
  
RUN apt-get install -y git  
  
ENTRYPOINT ["java","-cp","bin","HelloWorld"]  
  

