FROM golang:1.8.0-alpine  
  
ADD . /go/src/github.com/buoyantio/mesos-helium-framework  
ADD ./config /app/config  
  
RUN go install github.com/buoyantio/mesos-helium-framework && \  
cp /go/bin/mesos-helium-framework /app/ && \  
rm -rf /go/src/github.com/buoyantio  
  
WORKDIR /app  
ENTRYPOINT ["/app/mesos-helium-framework"]  

