FROM confluentinc/cp-kafka:5.0.1
COPY secrets/ /etc/kafka/secrets

ENV KAFKA_ADVERTISED_LISTENERS=SSL://localhost:9092
ENV KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR=1
ENV KAFKA_SSL_KEYSTORE_FILENAME=kafka.broker1.keystore.jks
ENV KAFKA_SSL_KEYSTORE_CREDENTIALS=broker1_keystore_creds
ENV KAFKA_SSL_KEY_CREDENTIALS=broker1_sslkey_creds
ENV KAFKA_SSL_TRUSTSTORE_FILENAME=kafka.broker1.truststore.jks
ENV KAFKA_SSL_TRUSTSTORE_CREDENTIALS=broker1_truststore_creds
ENV KAFKA_SECURITY_INTER_BROKER_PROTOCOL=SSL
ENV KAFKA_SSL_CLIENT_AUTH=required
ENV KAFKA_SSL_ENDPOINT_IDENTIFICATION_ALGORITHM=
ENV KAFKA_LISTENER_NAME_INTERNAL_SSL_ENDPOINT_IDENTIFICATION_ALGORITHM=
ENV KAFKA_ALLOW_EVERYONE_IF_NO_ACL_FOUND="true"
ENV KAFKA_AUTHORIZER_CLASS_NAME=kafka.security.auth.SimpleAclAuthorizer
