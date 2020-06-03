FROM java:8  
COPY HelloIppon.java /  
RUN javac HelloIppon.java  
ENTRYPOINT ["java", "HelloIppon"]  

