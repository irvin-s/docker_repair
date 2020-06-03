FROM confluentinc/cp-kafka-connect  
  
COPY . /usr/src/kafka-connect-hdfs  
WORKDIR /usr/src/kafka-connect-hdfs  
  
RUN docker/run.sh  

