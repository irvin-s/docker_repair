FROM alpine
MAINTAINER labulaka

# install  software
RUN sed -i 's/dl-cdn.alpinelinux.org\/alpine\/v3.7/mirrors.ustc.edu.cn\/alpine\/latest-stable/g' /etc/apk/repositories && \
	apk update && \
	apk add python3 iproute2 py3-cffi gcc make musl-dev  openssl-dev python3-dev libffi-dev vim && \
	rm -rf /var/cache/apk/*
