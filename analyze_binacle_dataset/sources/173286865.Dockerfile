FROM ubuntu

MAINTAINER Michael Hamrah <m@hamrah.com>

RUN \
  apt-get update && \
  apt-get install -y curl unzip net-tools netcat && \
  curl -L -o ./consul.zip https://github.com/hashicorp/envconsul/releases/download/v0.6.0/envconsul_0.6.0_linux_amd64.zip && \
  unzip ./consul.zip && \
  cp ./envconsul /usr/bin/ && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* *.gz

ADD envconsul-config.hcl /etc/envconsul-config.hcl
ADD envconsul-launch /usr/bin/envconsul-launch

RUN chmod +x /usr/bin/envconsul-launch

ENTRYPOINT ["envconsul-launch"]
