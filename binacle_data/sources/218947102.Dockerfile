# DynamoDB EventStore (github.com/adbrowne/DynamoEventStore)
#
# VERSION               0.0.1

FROM      ubuntu:14.04
MAINTAINER Andrew Browne <brownie@brownie.com.au>

RUN apt-get update && apt-get install -y curl libgmp10 && apt-get clean

RUN mkdir /opt/dynamoEventStore && curl -L https://github.com/adbrowne/DynamoEventStore/releases/download/v0.0.4/web > /opt/dynamoEventStore/web && chmod +x /opt/dynamoEventStore/web

EXPOSE 3000

WORKDIR /opt/dynamoEventStore

CMD ./web
