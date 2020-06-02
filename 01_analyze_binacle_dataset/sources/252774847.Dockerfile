FROM java:8  
MAINTAINER Docker Training Puppet <baudinet.jm@gmail.com>  
COPY src /root/javApp/src  
COPY bin /root/javApp/bin  
#COPY HelloWorld.java /  
WORKDIR /root/javApp  
RUN javac -d bin src/HelloWorld.java  
ENV APPNAME JavApp  
#RUN javac HelloWorld.java  
ENTRYPOINT ["/usr/bin/java","-cp","bin","HelloWorld"]  
#ENTRYPOINT ["java","HelloWorld"]  

