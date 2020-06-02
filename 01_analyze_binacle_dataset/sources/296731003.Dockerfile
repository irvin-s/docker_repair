FROM maven AS builder

RUN git clone https://github.com/sip3io/tapir.git
WORKDIR /tapir

RUN apt-get update && \
    apt-get install libpcap0.8

RUN mvn clean package

FROM java:alpine
MAINTAINER Windsent SIP3.IO <windsent@sip3.io>

RUN mkdir -p /etc/tapir-salto
RUN mkdir -p /opt/tapir-salto
RUN mkdir -p /var/log/tapir-salto

COPY --from=builder /tapir/salto/target/tapir-salto.jar /opt/tapir-salto
COPY --from=builder /tapir/package/etc/tapir-salto/logback.xml.example /opt/tapir-salto/
COPY --from=builder /tapir/package/etc/tapir-salto/tapir-salto.properties.example /opt/tapir-salto/
COPY --from=builder /tapir/package/docker/tapir-salto/tapir-salto /opt/tapir-salto/
RUN chmod +x /opt/tapir-salto/tapir-salto

EXPOSE 15060/udp

VOLUME ["/etc/tapir-salto", "/var/log/tapir-salto"]

CMD ["/opt/tapir-salto/tapir-salto"]
