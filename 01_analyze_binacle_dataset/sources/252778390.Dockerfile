FROM java:7  
COPY DoSomething.java .  
RUN javac DoSomething.java  
CMD ["Hello"]  
CMD ["java", "DoSomething"]  

