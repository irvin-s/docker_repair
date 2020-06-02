#This is Dockerfile  
FROM java:8  
COPY SimpleJavaApp.java .  
RUN javac SimpleJavaApp.java  
  
CMD ["java", "SimpleJavaApp"]

