FROM wurstmeister/kafka:0.9.0.1  
MAINTAINER Code Climate <hello@codeclimate.com>  
ADD cc-start-kafka.sh /usr/bin/cc-start-kafka.sh  
CMD ["cc-start-kafka.sh"]  

