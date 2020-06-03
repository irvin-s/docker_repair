FROM java:8  
COPY src /home/root/javahelloworld/src  
#COPY HelloWorld.java /  
WORKDIR /home/root/javahelloworld  
RUN mkdir bin && javac -d bin src/HelloWorld.java  
#RUN javac HelloWorld.java  
ENTRYPOINT ["java", "-cp", "bin", "HelloWorld"]  
#ENTRYPOINT ["java", "HelloWorld"]  

