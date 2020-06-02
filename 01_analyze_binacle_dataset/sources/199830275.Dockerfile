FROM java:8

RUN mkdir /app
WORKDIR /app

COPY iam-test-client.jar /app/
CMD java $IAM_CLIENT_JAVA_OPTS -jar iam-test-client.jar
