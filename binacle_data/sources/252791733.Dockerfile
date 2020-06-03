# Start from a Debian image with the latest version of Go installed  
# and a workspace (GOPATH) configured at /go.  
FROM golang  
  
# Copy the local package files to the container's workspace.  
ADD . /go/src/github.com/daltonclaybrook/go-transfer  
  
# Install dependencies  
RUN go get github.com/daltonclaybrook/swerve  
RUN go get github.com/gorilla/mux  
  
# Install go-transfer to the bin folder  
RUN go install github.com/daltonclaybrook/go-transfer  
  
# Run the go-transfer command by default when the container starts.  
ENTRYPOINT /go/bin/go-transfer  
  
# Set port ENV variable, and expose it.  
ENV PORT 8080  
EXPOSE 8080

