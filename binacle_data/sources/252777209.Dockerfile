FROM golang  
  
# Copy the local package files to the container's workspace.  
ADD ./src/server /go/src/github.com/golang/server  
ADD ./configuration.yml /go/configuration.yml  
  
RUN go install github.com/golang/server  
  
# Run the server by default when the container starts.  
ENTRYPOINT /go/bin/server  
  
# Document that the service listens on port 8080.  
EXPOSE 8080

