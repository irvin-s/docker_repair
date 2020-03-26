FROM java:openjdk-7  
WORKDIR /app  
COPY src/HelloWorld.java src/  
RUN mkdir bin  
RUN javac -sourcepath src -d bin src/HelloWorld.java  
ENV SALUTS "John Galt"  
RUN echo this bloody thing is starting  
ENTRYPOINT java -cp bin HelloWorld ${SALUTS}  
  

