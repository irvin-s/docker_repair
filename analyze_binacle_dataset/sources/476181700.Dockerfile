FROM murad/java8
MAINTAINER Dennis Vriend <dnvriend@gmail.com>

ADD /target/scala-2.11/spray-ba-sharding_2.11-0.0.1-one-jar.jar /appl/
ADD /docker/start /appl/
RUN chmod +x /appl/start

EXPOSE 8080
EXPOSE 2552
ENV BIND_ADDRESS 0.0.0.0
ENV BIND_PORT 8080

ENTRYPOINT [ "/appl/start" ]