FROM java:8-jre  
  
ENV VERTICLE_FILE todo/target/todo-1.0-SNAPSHOT-fat.jar  
ENV VERTICLE_HOME /app  
EXPOSE 3000  
RUN mkdir /app  
COPY $VERTICLE_FILE $VERTICLE_HOME  
WORKDIR $VERTICLE_HOME  
ENTRYPOINT ["sh", "-c"]  
CMD ["java -jar todo-1.0-SNAPSHOT-fat.jar"]  

