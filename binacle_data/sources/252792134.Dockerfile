FROM alpine:3.5  
  
ENV CLIENT_VERSION v1.5.8  
ENV CLIENT_REPO https://github.com/ethereum/go-ethereum  
  
WORKDIR /  
  
RUN apk add \--update git go make gcc musl-dev && \  
git clone -b ${CLIENT_VERSION} --single-branch ${CLIENT_REPO} && \  
(cd go-ethereum && \  
build/env.sh go run build/ci.go install ./cmd/disasm) && \  
cp go-ethereum/build/bin/disasm /disasm && \  
apk del git go make gcc musl-dev && \  
rm -rf /go-ethereum && rm -rf /var/cache/apk/*  
  
ENTRYPOINT /disasm  

