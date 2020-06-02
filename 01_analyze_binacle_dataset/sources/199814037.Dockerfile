# vim:set ft=dockerfile:
FROM debian:jessie

RUN apt-get update && apt-get install -y \
	git \
	make \
	gcc \
	gdb \
	python3 \
	libjansson-dev \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /raft

ENV REBUILD 3

#RUN git clone --depth 1 https://github.com/kvap/raft.git /raft
ADD . /raft
RUN cd /raft && make all

EXPOSE 6000
EXPOSE 6000/udp
ENTRYPOINT ["/raft/tests/docker-entrypoint.sh"]
#CMD ["bash"]
