FROM alpine:v2.0
MAINTAINER labulaka

# install  software
#RUN sed -i 's/dl-cdn.alpinelinux.org\/alpine\/v3.7/mirrors.ustc.edu.cn\/alpine\/latest-stable/g' /etc/apk/repositories && \
RUN	apk update && \
	apk add vim haproxy && \
	rm -rf /var/cache/apk/*
