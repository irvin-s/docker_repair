FROM java:8

RUN mkdir /app
WORKDIR /app

CMD java $IAM_CLIENT_JAVA_OPTS -jar $IAM_CLIENT_JAR
