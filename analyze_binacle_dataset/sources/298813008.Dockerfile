FROM ubuntu:yakkety

RUN apt-get update && apt-get install -y curl iptables

RUN curl https://raw.githubusercontent.com/habitat-sh/habitat/master/components/hab/install.sh | bash
RUN hab -V
RUN hab pkg install core/hab-pkg-dockerize

ENV DOCKER_VERSION 17.05.0-ce
RUN curl -sSL -O "https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz" \
      && tar zxf "docker-${DOCKER_VERSION}.tgz" \
      && mv ./docker/* /usr/local/bin/ \
      && chmod +x /usr/local/bin/* \
      && /usr/local/bin/docker --version

COPY start_docker /bin/
