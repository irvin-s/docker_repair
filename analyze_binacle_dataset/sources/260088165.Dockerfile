FROM confluentinc/cp-kafka:4.1.1
LABEL maintainer "maria.t.patterson@gmail.com"
ENV REFRESHED_AT 2018-07-25

ADD . /home/mm/ 

# Use the ENV below to run the default runMM.sh script 
#ENV KAFKA_ZOOKEEPER_CONNECT=zookeeper:32181
#ENV KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://kafka:9092
ENV KAFKA_BROKER_ID=1

WORKDIR /home/mm/

CMD ["./runMM.sh"]
