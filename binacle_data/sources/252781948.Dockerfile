FROM gliderlabs/alpine:3.4  
MAINTAINER chrisurwin  
  
EXPOSE 9777  
  
RUN addgroup cleanup \  
&& adduser -S -G cleanup cleanup  
ENV AWS_SDK_LOAD_CONFIG=1  
COPY ./*.go /go/src/github.com/chrisurwin/aws-rolling-asg/  
  
RUN apk --update add ca-certificates \  
&& apk --update add \--virtual build-deps go git \  
&& cd /go/src/github.com/chrisurwin/aws-rolling-asg \  
&& GOPATH=/go go get \  
&& GOPATH=/go go build -o /bin/aws-rolling-asg \  
&& apk del --purge build-deps \  
&& rm -rf /go/bin /go/pkg /var/cache/apk/*  
USER cleanup  
  
ENTRYPOINT [ "/bin/aws-rolling-asg" ]

