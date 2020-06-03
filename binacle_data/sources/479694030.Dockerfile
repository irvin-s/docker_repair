FROM java:8

ADD mockserver/target/mockserver-full.jar /mockserver.jar

EXPOSE 9999

RUN mkdir /externalSchema

VOLUME /externalSchema

CMD java -cp /mockserver.jar:/externalSchema pl.touk.mockserver.server.Main
