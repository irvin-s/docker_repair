FROM strimzi/java-base:8-3

ARG version=latest
ENV VERSION ${version}
ADD target/kafka-topic-webhook.jar /

CMD ["/bin/launch_java.sh", "/kafka-topic-webhook.jar"]