# gobgp (part of Ryu SDN Framework)
#

FROM osrg/quagga

MAINTAINER FUJITA Tomonori <fujita.tomonori@gmail.com>

RUN apt-get update
RUN apt-get install -qy --no-install-recommends wget lv tcpdump emacs24-nox

ENV HOME /root
WORKDIR /root
ENV GO111MODULE on

RUN git clone git://github.com/osrg/gobgp
RUN cd gobgp && go install ./cmd/gobgpd ./cmd/gobgp
