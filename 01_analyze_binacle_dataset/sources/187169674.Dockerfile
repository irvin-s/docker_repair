FROM python:3.7-stretch
LABEL MAINTAINER "amaya <mail@sapphire.in.net>"

COPY . /opt/k8s-debugkit
WORKDIR /opt/k8s-debugkit

RUN set -eux && \
    pip install -r requirements.txt && \
    wget https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
      -O /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl && \
    apt update && \
    apt install -y nano vim emacs \
                   dnsutils traceroute && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

CMD ["./run.sh"]
