FROM maven AS builder

RUN git clone https://github.com/sip3io/tapir.git
WORKDIR /tapir

RUN apt-get update && \
    apt-get install libpcap0.8

RUN mvn clean package

FROM java:alpine
MAINTAINER Windsent SIP3.IO <windsent@sip3.io>

RUN mkdir -p /etc/tapir-twig
RUN mkdir -p /opt/tapir-twig
RUN mkdir -p /var/log/tapir-twig

COPY --from=builder /tapir/twig/target/tapir-twig.jar /opt/tapir-twig
COPY --from=builder /tapir/package/etc/tapir-twig/logback.xml.example /opt/tapir-twig/
COPY --from=builder /tapir/package/etc/tapir-twig/tapir-twig.properties.example /opt/tapir-twig/
COPY --from=builder /tapir/package/docker/tapir-twig/tapir-twig /opt/tapir-twig/
RUN chmod +x /opt/tapir-twig/tapir-twig

EXPOSE 8080

VOLUME ["/etc/tapir-twig", "/var/log/tapir-twig"]

CMD ["/opt/tapir-twig/tapir-twig"]
