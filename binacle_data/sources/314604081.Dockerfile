FROM debian:stretch

ARG VSTS_VERSION=2.131.0

WORKDIR /agent
RUN useradd vsts

RUN apt-get update \
  && apt-get install -y git python python-setuptools python-pip \
  && rm -rf /var/lib/apt/lists/* \
  && pip install wheel

ADD https://vstsagentpackage.azureedge.net/agent/$VSTS_VERSION/vsts-agent-linux-x64-$VSTS_VERSION.tar.gz .
RUN tar xzf vsts-agent-linux-x64-$VSTS_VERSION.tar.gz \
  && ./bin/installdependencies.sh \
  && chown -R vsts:vsts /agent

USER vsts

ENTRYPOINT ["/bin/bash", "-c", "./config.sh --unattended --replace && ./run.sh"]