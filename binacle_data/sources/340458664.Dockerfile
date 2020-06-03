FROM golang:1.4

ENV DEBIAN_FRONTEND noninteractive

RUN export PATH=$PATH:/go/bin
ADD conf.json.example /etc/bangarang/conf.json
RUN mkdir /etc/bangarang/alerts

# fetch gb
RUN go get github.com/constabulary/gb/...

# build the command_
RUN mkdir /tmp/bangarang
COPY src /tmp/bangarang/src
COPY vendor /tmp/bangarang/vendor
RUN cd /tmp/bangarang && gb build github.com/eliothedeman/bangarang/cmd/bangarang
RUN cp /tmp/bangarang/bin/bangarang /go/bin/bangarang

EXPOSE 5555 
EXPOSE 5556 
EXPOSE 8081 

VOLUME /etc/bangarang

ENTRYPOINT /go/bin/bangarang -conf-type=json -conf=/etc/bangarang/confs
