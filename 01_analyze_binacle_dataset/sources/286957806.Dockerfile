FROM golang
RUN go get -u github.com/golang/dep/cmd/dep
ADD . /go/src/github.com/bketelsen/ngc
WORKDIR /go/src/github.com/bketelsen/ngc
RUN make clean
RUN make all
CMD /go/src/github.com/bketelsen/ngc/bin/ngc
