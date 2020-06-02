FROM java:7  
COPY JavaMeetsDocker.java .  
RUN javac JavaMeetsDocker.java  
  
CMD ["java","JavaMeetsDocker"]  

