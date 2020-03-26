FROM haproxy:latest

ENV CONSUL_TEMPLATE_VERSION=0.15.0

#COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg

RUN  apt-get update \
  && apt-get install -y wget unzip \
  && rm -rf /var/lib/apt/lists/*

# Download consul-template
RUN ( wget --no-check-certificate https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip -O /tmp/consul_template.zip && unzip /tmp/consul_template.zip -d /tmp && cd /tmp && mv consul-template /usr/bin && rm -rf /tmp/consul-template* )

COPY haproxy.json /tmp/haproxy.json
COPY haproxy.ctmpl /tmp/haproxy.ctmpl
COPY start.sh /usr/bin/start.sh

ENTRYPOINT ["/usr/bin/start.sh"]
