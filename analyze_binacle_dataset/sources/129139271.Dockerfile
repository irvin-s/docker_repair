FROM openjdk:8-jre

RUN apt-get update && apt-get install -y bc

COPY svc /svc

ENTRYPOINT ["svc/bin/startService.sh"]