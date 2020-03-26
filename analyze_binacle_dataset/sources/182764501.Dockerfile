# same FROM as kafka-jre, to keep pull times down and to provide the same shell distro+version
FROM debian:stretch-slim@sha256:6c31161e090aa3f62b9ee1414b58f0a352b42b2b7827166e57724a8662fe4b38

ENV KUBERNETES_VERSION=1.13.5 KUBERNETES_CLIENT_SHA512=11439519bbf81aca17cd883c3f8fbeb6ad0b6d4360e17c9c45303c5fb473ebe6a9be32ca2df27a492a16fcc94b221eeb8e2dbefbb1937a5627ee26c231742b7d

RUN set -ex; \
  export DEBIAN_FRONTEND=noninteractive; \
  runDeps='curl ca-certificates procps netcat'; \
  buildDeps=''; \
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
