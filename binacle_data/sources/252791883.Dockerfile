FROM java:8  
MAINTAINER Srini<seeni45<at>gmail<dot>com>  
  
COPY src /home/root/java/src  
WORKDIR /home/root/java  
RUN mkdir bin  
RUN javac -d bin src/main/java/org/cheetah/HelloCheetah.java  
  
EXPOSE 8080  
EXPOSE 80  
ENTRYPOINT ["java", "-cp", "bin", "org.cheetah.HelloCheetah"]  
  
ONBUILD ADD . /home/test.txt  

