# Start from an Alpine image with the latest version of Go installed  
# and a workspace (GOPATH) configured at /go.  
FROM golang:alpine  
  
# Build the outyet command inside the container.  
# (You may fetch or manage dependencies here,  
# either manually or with a tool like "godep".)  
RUN apk add --update \  
gcc \  
libc-dev \  
git \  
lm_sensors-dev \  
&& rm -rf /var/cache/apk/*  
  
RUN go get \  
github.com/amkay/gosensors \  
github.com/prometheus/client_golang/prometheus  
  
# Copy the local package files to the container's workspace.  
ADD sensor-exporter /go/src/github.com/ncabatoff/sensor-exporter  
  
RUN go install github.com/ncabatoff/sensor-exporter  
  
# Run the outyet command by default when the container starts.  
ENTRYPOINT [ "/go/bin/sensor-exporter" ]  
  
# Document that the service listens on port 9255.  
EXPOSE 9255  

