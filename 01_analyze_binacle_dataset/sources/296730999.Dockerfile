FROM maven AS builder

RUN git clone https://github.com/sip3io/tapir.git
WORKDIR /tapir

RUN apt-get update && \
    apt-get install libpcap0.8

RUN mvn clean package

FROM java:alpine
MAINTAINER Windsent SIP3.IO <windsent@sip3.io>

RUN mkdir -p /etc/tapir-captain
RUN mkdir -p /opt/tapir-captain
RUN mkdir -p /var/log/tapir-captain

COPY --from=builder /tapir/captain/target/tapir-captain.jar /opt/tapir-captain
COPY --from=builder /tapir/package/etc/tapir-captain/logback.xml.example /opt/tapir-captain/
COPY --from=builder /tapir/package/etc/tapir-captain/tapir-captain.properties.example /opt/tapir-captain/
COPY --from=builder /tapir/package/docker/tapir-captain/tapir-captain /opt/tapir-captain/
RUN chmod +x /opt/tapir-captain/tapir-captain

RUN apk update && \
    apk add libpcap

VOLUME ["/etc/tapir-captain", "/var/log/tapir-captain", "/var/lib/tapir"]

CMD ["/opt/tapir-captain/tapir-captain"]
