FROM ubuntu:xenial

LABEL Description="SPIRE Demo: ghostunnel"
LABEL vendor="scytale.io"
LABEL version="0.1.0"

RUN apt-get update -y
RUN apt-get -y install \
	git \
	wget \
	curl \
	libltdl7

COPY ghostunnel ${HOME}
COPY start.sh ${HOME}
RUN cd ${HOME} && curl --silent --location https://github.com/spiffe/sidecar/releases/download/0.1/sidecar_0.1_linux_amd64.tar.gz | tar xzf -

CMD ./${HOME}/start.sh


