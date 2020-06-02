# Cisco Packet Tracer Dockerfile
# author: Loan Lassalle

FROM ubuntu

LABEL maintainer "Loan Lassalle"

RUN apt-get update \
    && apt-get install -y qtmultimedia5-dev libqt5webkit5-dbg libqt5script5 libqt5webkit5 libqt5scripttools5 libqt5svg5 libssl1.0.0 ca-certificates wget \
    && mkdir -p /opt/pt \
    && wget -P /tmp/pt http://www.labcisco.com.br/app/Cisco-PT-711-x64.tar \
    && tar -xvf /tmp/pt/Cisco-PT-711-x64.tar -C /opt/pt \
    && sed 's/III/\/opt\/pt/' /opt/pt/tpl.packettracer > /opt/pt/packettracer \
    && sed -i 's/^export/# export/' /opt/pt/packettracer \
    && sed 's/III/\/opt\/pt/' /opt/pt/tpl.linguist > /opt/pt/linguist \
    && chmod +x /opt/pt/linguist /opt/pt/packettracer \
    && apt-get clean \
    && rm -rf /tmp/pt /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["/opt/pt/packettracer"]