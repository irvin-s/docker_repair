FROM java:7  
COPY GoodLuck.java .  
RUN javac GoodLuck.java  
  
CMD ["java", "GoodLuck"]  
  

