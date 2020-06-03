FROM ubuntu:14.04

MAINTAINER tsuru <tsuru@corp.globo.com>
ENV ct_version 0.11.0
RUN apt-get install -y wget unzip
RUN wget https://github.com/hashicorp/consul-template/releases/download/v${ct_version}/consul_template_${ct_version}_linux_amd64.zip \
	&& unzip consul_template_${ct_version}_linux_amd64.zip -d /bin \
	&& rm -rf consul-template_${ct_version}_linux_amd64.tar.gz

RUN wget https://get.docker.com/builds/Linux/x86_64/docker-latest -O /bin/docker
RUN chmod +x /bin/docker

COPY ./consul-template.conf /etc/consul-template.conf
COPY ./tsuru.ctmpl /tmp/tsuru.ctmpl
COPY ./redis.ctmpl /tmp/redis.ctmpl
COPY ./hipache.ctmpl /tmp/hipache.ctmpl
COPY ./gandalf.ctmpl /tmp/gandalf.ctmpl
COPY ./pre-receive.ctmpl /tmp/pre-receive.ctmpl
COPY ./archive-server.ctmpl /tmp/archive-server.ctmpl

ENV DOCKER_HOST unix:///tmp/docker.sock

LABEL "name"="consul-template"

ENTRYPOINT ["/bin/consul-template", "-config", "/etc/consul-template.conf"]
