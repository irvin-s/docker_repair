FROM java:8  
WORKDIR /helloworld  
COPY src /helloworld  
ENV FOO bar  
RUN mkdir bin  
RUN javac -d bin HelloWorld.java  
ENTRYPOINT ["java", "-cp", "bin", "HelloWorld"]  

