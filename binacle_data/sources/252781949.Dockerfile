FROM gliderlabs/alpine:3.4  
MAINTAINER chrisurwin  
  
EXPOSE 9777  
  
RUN addgroup spot \  
&& adduser -S -G spot spot  
COPY ./*.go /go/src/github.com/chrisurwin/aws-spot-instance-helper/  
  
RUN apk --update add ca-certificates \  
&& apk --update add \--virtual build-deps go git \  
&& cd /go/src/github.com/chrisurwin/aws-spot-instance-helper \  
&& GOPATH=/go go get \  
&& GOPATH=/go go build -o /bin/aws-spot-instance-helper \  
&& apk del --purge build-deps \  
&& rm -rf /go/bin /go/pkg /var/cache/apk/*  
USER spot  
  
ENTRYPOINT [ "/bin/aws-spot-instance-helper" ]

