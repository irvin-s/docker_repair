# Builds a docker image with command-line tools for the Confluent platform.  
FROM cgswong/confluent-platform:2.0.1  
COPY confluent-tools.sh /  
ENTRYPOINT ["/confluent-tools.sh"]  
CMD ["kafka-avro-console-consumer"]  

