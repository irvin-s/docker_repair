FROM confluentinc/cp-kafka-rest  
  
COPY . /app/src  
WORKDIR /app/src  
  
RUN docker/run.sh  

