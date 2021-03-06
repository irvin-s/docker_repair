# Cloud9 server for glang dev
# A lot inspired by https://hub.docker.com/_/golang/ (near similar instruction but based on cloud9, GOPATH /workspace)

FROM sapk/cloud9
LABEL maintainer="Antoine GIRARD <antoine.girard@sapk.fr>"

# gcc for cgo
RUN apt-get update && apt-get install -y --no-install-recommends \
		g++ \
		gcc \
		libc6-dev \
		make \
	&& rm -rf /var/lib/apt/lists/*

ENV GOLANG_VERSION 1.12.6
ENV GOLANG_DOWNLOAD_URL https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz
ENV GOLANG_DOWNLOAD_SHA256 dbcf71a3c1ea53b8d54ef1b48c85a39a6c9a935d01fc8291ff2b92028e59913c

ENV GOPATH /workspace
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN curl -fsSL "$GOLANG_DOWNLOAD_URL" -o golang.tar.gz \
	&& echo "$GOLANG_DOWNLOAD_SHA256  golang.tar.gz" | sha256sum -c - \
	&& tar -C /usr/local -xzf golang.tar.gz \
	&& echo 'export PATH=$GOPATH/bin:/usr/local/go/bin:$PATH' >> /root/.bashrc \
	&& rm golang.tar.gz 
