# Start from a Debian image with the latest version of Go installed  
# and a workspace (GOPATH) configured at /go.  
FROM golang  
  
# Copy the local package files to the container's workspace.  
ADD . /go  
RUN ls -l /go  
  
# (You may fetch or manage dependencies here,  
# either manually or with a tool like "godep".)  
RUN go get github.com/gin-gonic/gin  
RUN go build /go/src/app/incomeevaluator.go  
RUN ls -l  
  
# Run the output command by default when the container starts.  
ENTRYPOINT /go/incomeevaluator > incomeevaluator.log  
  
# Document that the service listens on port 7052.  
EXPOSE 7052

