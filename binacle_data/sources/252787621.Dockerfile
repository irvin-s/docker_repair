FROM brscrt/java-8  
MAINTAINER Baris Cirit "brscrt@gmail.com"  
ADD KafkaConsumerGr-latest.tar /  
ENTRYPOINT ["/KafkaConsumerGr-latest/bin/KafkaConsumerGr"]  

