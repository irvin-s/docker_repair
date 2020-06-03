# https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DynamoDBLocal.html
FROM openjdk:8-jre

EXPOSE 8000
ENTRYPOINT ["/usr/bin/java", "-Djava.library.path=/app/dynamodb", "-jar", "DynamoDBLocal.jar"]

RUN mkdir -p /app/dynamodb
WORKDIR /app/dynamodb

RUN wget -q https://s3-us-west-2.amazonaws.com/dynamodb-local/dynamodb_local_latest.tar.gz -O - | tar xz
