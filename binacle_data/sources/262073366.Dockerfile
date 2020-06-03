FROM ubuntu:16.04

MAINTAINER Mark Church <church@docker.com>

RUN apt-get update &&\
  apt-get install -y apt-transport-https ca-certificates curl jq &&\
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - &&\
  echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable edge" > /etc/apt/sources.list.d/docker.list &&\
  apt-get update &&\
  apt-get install -y docker-ce &&\
  rm -rf /var/lib/apt/lists/* /etc/apt/sources.list.d/docker.list

RUN mkdir /dtrctl

COPY dtrctl.sh /dtrctl/dtrctl.sh

WORKDIR /dtrctl

ENTRYPOINT ["/dtrctl.sh"]

CMD ["--help"]
