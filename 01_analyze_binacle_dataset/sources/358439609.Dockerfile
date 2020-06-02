FROM alpine:3.5

RUN apk update && apk --update add curl && \
	curl -sL  https://github.com/coreos/etcd/releases/download/v2.3.7/etcd-v2.3.7-linux-amd64.tar.gz -o etcd-v2.3.7-linux-amd64.tar.gz && \
	tar xzvf etcd-v2.3.7-linux-amd64.tar.gz && \
	mv etcd-v2.3.7-linux-amd64/etcdctl /usr/bin/ && \
	rm etcd-v2.3.7-linux-amd64.tar.gz && \
	rm -rf etcd-v2.3.7-linux-amd64/
