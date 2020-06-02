FROM java  
COPY JavaHelloWorld.java .  
RUN javac JavaHelloWorld.java  
  
CMD ["java", "JavaHelloWorld"]  

