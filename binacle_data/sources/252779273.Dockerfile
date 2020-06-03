FROM golang:1.10-alpine as builder  
  
ARG GO_PKG=github.com/c0va23/redirector  
ENV SRC_PATH=/go/src/${GO_PKG}/  
  
WORKDIR ${SRC_PATH}  
  
RUN apk add --update \  
make \  
git \  
|| true  
  
ADD Makefile ${SRC_PATH}  
  
RUN make dev-deps  
  
ADD Gopkg.lock Gopkg.toml ${SRC_PATH}  
  
RUN make deps  
  
ADD api.yml ${SRC_PATH}  
  
RUN make gen-swagger  
  
ADD . ${SRC_PATH}  
  
RUN go install ${GO_PKG}/cmd/redirector-server  
  
FROM alpine:3.7  
COPY \--from=builder /go/bin/redirector-server /usr/local/bin  
  
ENV PORT=8080  
EXPOSE ${PORT}  
  
CMD redirector-server --port ${PORT} \--host 0.0.0.0  

