FROM golang:1.9  
# Copy the local package files to the container's workspace.  
ADD . /go/src/github.com/allistera/juno-probe  
  
WORKDIR /go/src/github.com/allistera/juno-probe  
  
RUN go get ./  
RUN go build  
  
# Run the outyet command by default when the container starts.  
ENTRYPOINT juno-probe  

