FROM java:8  
#COPY HelloWorld.java /  
COPY src /home/root/javahelloworld/src  
WORKDIR /home/root/javahelloworld  
#RUN javac HelloWorld.java  
RUN mkdir bin && javac -d bin src/HelloWorld.java  
#ENTRYPOINT ["java", "HelloWorld"]  
ENTRYPOINT ["java", "-cp", "bin", "HelloWorld"]  

