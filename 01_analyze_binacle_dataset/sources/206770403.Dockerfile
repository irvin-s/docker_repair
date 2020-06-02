FROM debian:8
MAINTAINER Ragnar B. Johannsson <ragnar@igo.is>

RUN apt-get update \
    && apt-get install -y \
        curl \
        openssh-server \
        python-crypto \
        python-flask \
    && systemctl enable ssh

COPY /config/sshd_config /etc/ssh/
COPY /scripts/ /

COPY onetime-keypairs/*.service /etc/systemd/system/
COPY onetime-keypairs/*.py /opt/

RUN systemctl enable keypair-server-config.service \
    && systemctl enable keypair-server.service

ENTRYPOINT ["/lib/systemd/systemd"]
