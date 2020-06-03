FROM golang:1.6  
# Create app directory  
RUN mkdir -p /go/src/github.com/tus/tusd  
RUN git clone https://github.com/tus/tusd.git /go/src/github.com/tus/tusd  
WORKDIR /go/src/github.com/tus/tusd  
RUN go get -d -v ./...  
RUN go install -v  
VOLUME ["/go/src/github.com/tus/tusd/data"]  
EXPOSE 1080  
CMD ["go", "run", "/go/src/github.com/tus/tusd/cmd/tusd/main.go"]  

