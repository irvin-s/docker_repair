FROM rabbitmq

RUN rabbitmq-plugins enable rabbitmq_consistent_hash_exchange
RUN rabbitmq-plugins enable rabbitmq_management	
