#FROM dockcross/linux-x86:latest
FROM dockcross/linux-armv6
#FROM dockcross/linux-armv7

# Largely copied from the official Golang image Dockerfile

RUN set -eux; \
  wget -O go.tgz "https://golang.org/dl/go1.9.1.linux-amd64.tar.gz"; \
  tar -C /usr/local -xzf go.tgz; \
  rm go.tgz; \
  export PATH="/usr/local/go/bin:$PATH"; \
	go version

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH
