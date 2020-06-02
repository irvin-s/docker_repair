FROM openjdk:8-jre-alpine

ADD target/slackingbird-*-standalone.jar /app/slackingbird.jar
ADD docker/entrypoint /

RUN chmod +x /entrypoint

EXPOSE 3000

CMD /entrypoint