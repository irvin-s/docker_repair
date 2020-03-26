FROM ubuntu:trusty

MAINTAINER DRUD DOCKER <docker@drud.io>

ENV VAULT_VERSION 0.6.0
ENV VAULT_SHA256 283b4f591da8a4bf92067bf9ff5b70249f20705cc963bea96ecaf032911f27c2
ENV DEBIAN_FRONTEND noninteractive
ENV ANSIBLE_HOST_KEY_CHECKING False
ENV ANSIBLE_FORCE_COLOR True

COPY apt-requirements.txt /
COPY pip-requirements.txt /
ADD https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip /tmp/vault.zip

RUN  apt-get update -y \
  && apt-get install -y -q $(cat /apt-requirements.txt) \
  && pip install --upgrade pip \
  && pip install -r /pip-requirements.txt \
  && echo "${VAULT_SHA256} */tmp/vault.zip" | sha256sum -c - \
  && cd /bin && unzip /tmp/vault.zip && chmod +x /bin/vault && rm /tmp/vault.zip

COPY files /

WORKDIR /app
ENTRYPOINT ["/usr/bin/python", "sanctuary.py"]
CMD ["create"]
