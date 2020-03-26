FROM golang:1.10-alpine as builder  
  
RUN apk add -U gcc musl-dev  
  
COPY . /go/src/github.com/brimstone/blinktd/  
  
WORKDIR /go/src/github.com/brimstone/blinktd/  
  
ARG GOARCH=amd64  
ARG GOARM=6  
ENV GOARCH="$GOARCH" \  
GOARM="$GOARM"  
RUN if [ "${GOARCH}" == "${GOHOSTARCH}" ]; then \  
go build -v -o /go/bin/blinktd -a -installsuffix cgo \  
-ldflags "-linkmode external -extldflags \"-static\" -s -w "; \  
else \  
go build -v -o /go/bin/blinktd -ldflags "-s -w"; \  
fi  
  
FROM scratch  
  
ARG BUILD_DATE  
ARG VCS_REF  
  
LABEL org.label-schema.build-date=$BUILD_DATE \  
org.label-schema.vcs-url="https://github.com/brimstone/blinktd" \  
org.label-schema.vcs-ref=$VCS_REF \  
org.label-schema.schema-version="1.0.0-rc1"  
  
COPY \--from=builder /go/bin/blinktd /blinktd  
  
ENTRYPOINT ["/blinktd"]  
CMD ["serve"]  

