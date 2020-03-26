FROM golang:1.6.2

RUN apt-get install -y git
RUN git clone https://github.com/andrzej-k/heapster.git /go/src/k8s.io/heapster
RUN cd /go/src/k8s.io/heapster && git checkout remotes/origin/snap

ENV GOMAXPROCS=1
RUN cd /go/src/k8s.io/heapster && make && mv heapster /heapster && mv eventer /eventer

ENTRYPOINT ["/heapster"]
