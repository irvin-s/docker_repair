FROM maven:3.6-jdk-8-alpine as builder

RUN cd /tmp
COPY . .

RUN mvn package


FROM java:openjdk-8-jdk

ENV DBMAINTAIN_VERSION=2.7.4-SNAPSHOT

COPY --from=builder dbmaintain/target/dbmaintain-${DBMAINTAIN_VERSION}.jar /lib/
RUN useradd -m -d /opt/dbmaintain dbmaintain -u 1000\
    && touch /opt/dbmaintain/prescriptsqlpus.sql\
    && touch /opt/dbmaintain/postscriptsqlpus.sql
COPY docker/entrypoint.sh /opt/dbmaintain/
COPY dbmaintain/src/main/resources/dbmaintain-default.properties /opt/dbmaintain/dbmaintain.properties
RUN chown dbmaintain:dbmaintain -R /opt/dbmaintain/ && chmod -R a+r /lib
USER dbmaintain
ENTRYPOINT ["/opt/dbmaintain/entrypoint.sh"]
