FROM golang:latest  
  
# Install zglob for export task  
COPY zglob.go /go/src/convey/zglob/main.go  
RUN go get convey/zglob ./... && go install convey/zglob  
  
WORKDIR "/workspace"  
CMD ["/bin/bash"]  

