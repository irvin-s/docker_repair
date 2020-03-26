FROM java:8  
VOLUME /tmp  
  
COPY HelloKube.java .  
  
RUN javac HelloKube.java  
  
CMD ["java", "HelloKube"]  

