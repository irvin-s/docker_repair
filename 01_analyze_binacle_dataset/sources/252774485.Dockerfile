FROM java:7  
ADD HelloWorld.java .  
RUN javac HelloWorld.java  
CMD ["java", "hellowword"]  

