FROM openjdk:8u111
MAINTAINER friedrich@fornever.me
RUN apt-get update && apt-get install -y supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY horta-hell.jar /opt/codingteam/horta-hell/horta-hell.jar
VOLUME ["/data"]
CMD ["/usr/bin/supervisord"]
