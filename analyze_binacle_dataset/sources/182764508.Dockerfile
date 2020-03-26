FROM cfssl/cfssl@sha256:f5ca56a93dbb5506d79833cf4869dcca0df4e2d200d5eff9856f35041505d2a7 \
  as cfssl

RUN whereis cfssl
RUN whereis cfssljson

FROM debian:stretch-slim@sha256:40b4072ce18fabe32f357f7c9ec1d256d839b1b95bcdc1f9c910823c6c2932e9

ENV KUBERNETES_VERSION=1.11.3 KUBERNETES_CLIENTS_SHA256=14a70ac05c00fcfd7d632fc9e7a5fbc6615ce1b370bb1a0e506a24972d461493

RUN set -ex; \
  export DEBIAN_FRONTEND=noninteractive; \
  runDeps='procps'; \
  buildDeps='curl ca-certificates'; \
  apt-get update && apt-get install -y $runDeps $buildDeps --no-install-recommends; \
  rm -rf /var/lib/apt/lists/*; \
  \
  curl -sLS -o k.tar.gz -k https://dl.k8s.io/v${KUBERNETES_VERSION}/kubernetes-client-linux-amd64.tar.gz; \
  echo "$KUBERNETES_CLIENTS_SHA256  k.tar.gz" | sha256sum -c; \
  tar -xvzf k.tar.gz -C /usr/local/bin/ --strip-components=3 kubernetes/client/bin/kubectl; \
  rm k.tar.gz; \
  \
  apt-get purge -y --auto-remove $buildDeps; \
  rm /var/log/dpkg.log /var/log/apt/*.log

RUN kubectl version --client

COPY --from=cfssl /go/bin/cfssl* /usr/local/bin/
RUN cfssl version
