FROM java:7  
COPY Test.java .  
RUN javac Test.java  
CMD ["java", "Test"]  

