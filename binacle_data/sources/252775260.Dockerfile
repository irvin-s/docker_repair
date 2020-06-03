FROM golang:1.8-alpine  
RUN apk --no-cache update && \  
apk --no-cache add git vim nano && \  
rm -rf /var/cache/apk/*  
RUN go get go.mozilla.org/sops/cmd/sops \  
&& cd /go/src/go.mozilla.org/sops/cmd/sops \  
&& git checkout cb2340c \  
&& go install go.mozilla.org/sops/cmd/sops  
ENV EDITOR vim  
ENTRYPOINT ["/go/bin/sops"]  

