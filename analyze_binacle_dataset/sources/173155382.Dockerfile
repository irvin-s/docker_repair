FROM        busybox
MAINTAINER  Joel Bastos <kintoandar@gmail.com>

ENV VERSION "0.9.2"

ADD https://releases.hashicorp.com/consul/${VERSION}/consul_${VERSION}_linux_amd64.zip /tmp/consul_${VERSION}_linux_amd64.zip
RUN unzip -o /tmp/consul_${VERSION}_linux_amd64.zip -d /bin/ && rm /tmp/consul_${VERSION}_linux_amd64.zip

EXPOSE 8300 8301 8302 8400 8500 8600 8301/udp 8302/udp 8600/udp

ENTRYPOINT ["/bin/consul"]

CMD ["agent", "-server", "-dev", "-log-level=debug", "0.0.0.0"]
