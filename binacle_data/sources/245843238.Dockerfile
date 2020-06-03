FROM debian:jessie

ENV DEBIAN_FRONTEND=noninteractive

RUN	apt-get update && \
	apt-get install --no-install-recommends -y openjdk-7-jdk make scala && \
	apt-get clean -y

WORKDIR /root/fimpp

COPY	bin bin
COPY	examples examples
COPY	src src
COPY	test test
COPY	run_tests.sh .
COPY	Makefile .

ENV PATH=/root/fimpp/bin:$PATH

RUN	make && \
	make test

ENTRYPOINT ["fimpp"]
