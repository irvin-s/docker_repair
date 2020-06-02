FROM frolvlad/alpine-oraclejdk8:slim
MAINTAINER "ffinkbeiner@inovex.de"

EXPOSE 8080

COPY mattermost-loader-fatjar.jar app.jar

ENV JAVA_OPTS=""


#set the kafkatopic and kafkaconnect to your preferences
#--kafkatopic test --kafkaconnect kafka.kubeyard:9092
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app.jar --kafkatopic test --kafkaconnect kafka.kubeyard:9092" ]
