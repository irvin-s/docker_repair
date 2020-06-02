FROM brscrt/java-8  
MAINTAINER Baris Cirit "brscrt@gmail.com"  
ADD KafkaProducer_Gr-latest.tar /  
ENTRYPOINT ["/KafkaProducer_Gr-latest/bin/KafkaProducer_Gr"]  

