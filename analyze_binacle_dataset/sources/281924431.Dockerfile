FROM anapsix/alpine-java:8
MAINTAINER gaozhiwen <gaulzhw@gmail.com>

EXPOSE 8080
COPY mykingdom-imking.jar /app/mykingdom-imking.jar

COPY start.sh /app/start.sh

RUN chmod +x /app/start.sh

ENV JAVA_OPTS=""
ENTRYPOINT [ "sh", "-c", "/app/start.sh" ]
