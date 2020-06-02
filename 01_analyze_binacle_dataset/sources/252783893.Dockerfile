FROM java:8  
COPY HelloWorld.java /HelloWorld.java  
RUN javac HelloWorld.java  
CMD ["java","HelloWorld"]  

