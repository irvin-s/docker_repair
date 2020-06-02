FROM java:7  
COPY Hello.java .  
RUN javac Hello.java  
  
CMD ["java", "Hello"]  

