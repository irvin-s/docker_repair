FROM ubuntu:18.04

ARG GRAALVM_VERSION

RUN apt-get update && \
  apt-get install -y curl && \
  curl -Ls "https://github.com/oracle/graal/releases/download/vm-${GRAALVM_VERSION}/graalvm-ce-${GRAALVM_VERSION}-linux-amd64.tar.gz" | \
  tar zx -C /usr/local/ && \
  rm -f /usr/local/graalvm-${GRAALVM_VERSION}/src.zip && \
  ln -s /usr/local/graalvm-${GRAALVM_VERSION} /usr/local/graalvm && \
  rm -fr /var/lib/apt

ENV PATH /usr/local/graalvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

CMD java -version
