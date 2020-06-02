# Image: pubnative/vpn

FROM hwdsl2/ipsec-vpn-server
MAINTAINER Pubnative Tech <team@pubnative.net>

ENV DESTINATION_NET ""
ENV ALLOWED_SERVICES ""

RUN apt update \
    && apt install -y ipset \
    && rm -rf /var/cache/apt/*

COPY ./run.sh /opt/src/run.sh
RUN chmod 755 /opt/src/run.sh

CMD ["bash", "/opt/src/run.sh"]
