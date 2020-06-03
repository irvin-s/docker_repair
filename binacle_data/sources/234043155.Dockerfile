FROM centos:7
MAINTAINER lufia

RUN	yum update -y && \
	yum install -y ca-certificates fuse
RUN	useradd -u 1000 taskfs && \
	mkdir /mnt/taskfs && \
	chown taskfs:taskfs /mnt/taskfs
ADD	taskfs /usr/local/bin

WORKDIR	/home/taskfs
USER	taskfs
