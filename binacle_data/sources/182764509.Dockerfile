FROM solsson/kafkacat@sha256:5bf858fde6fffbaaf0278fd27458626f96bc908a440ba434536841bb79c70e25

ENV KUBERNETES_VERSION=1.13.1 KUBERNETES_CLIENT_SHA512=ca00442f50b5d5627357dce97c90c17cb0126d746b887afdab2d4db9e0826532469fd1ee62f40eb6923761618f46752d10993578ca19c8b92c3a2aeb5102a318

RUN set -ex; \
  export DEBIAN_FRONTEND=noninteractive; \
  runDeps='procps'; \
  buildDeps='curl ca-certificates'; \
  apt-get update && apt-get install -y $runDeps $buildDeps --no-install-recommends; \
  rm -rf /var/lib/apt/lists/*; \
  \
  curl -sLS -o k.tar.gz -k https://dl.k8s.io/v${KUBERNETES_VERSION}/kubernetes-client-linux-amd64.tar.gz; \
  echo "$KUBERNETES_CLIENT_SHA512  k.tar.gz" | sha512sum -c; \
  tar -xvzf k.tar.gz -C /usr/local/bin/ --strip-components=3 kubernetes/client/bin/kubectl; \
  rm k.tar.gz; \
  \
  apt-get purge -y --auto-remove $buildDeps; \
  rm /var/log/dpkg.log /var/log/apt/*.log

ENTRYPOINT ["kubectl"]
