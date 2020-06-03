# Start from a Debian image with the latest version of Go installed  
# and a workspace (GOPATH) configured at /go.  
FROM golang:1.6-alpine  
  
ENV GO15VENDOREXPERIMENT="1"  
# Copy the local package files to the container's workspace.  
COPY . /go/src/github.com/coralproject/pillar  
  
# Build & Install  
RUN cd /go/src && go install github.com/coralproject/pillar/app/pillar  
  
# Run the app  
ENTRYPOINT /go/bin/pillar  
  
# Document that the service listens on port 8080.  
EXPOSE 8080  

