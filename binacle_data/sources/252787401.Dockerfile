FROM openjdk:8  
ENV ROSS POGI  
ENV SPARK_HOME /spark  
  
WORKDIR /HelloWorld  
RUN mkdir src  
COPY ./javasrc ./src  
RUN mkdir bin  
RUN javac -d bin ./src/HelloWorld.java  
  
ENTRYPOINT ["java", "-cp", "bin", "HelloWorld", ">", "/mounted/output.txt"]  
RUN mkdir /mounted -p  
RUN echo "hi there" > /mounted/test.txt  
VOLUME /mounted  
  

