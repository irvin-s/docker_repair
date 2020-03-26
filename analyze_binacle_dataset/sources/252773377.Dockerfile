FROM golang:1.9.6-alpine  
RUN mkdir -p /go/src/github.com/bigphattoby/weeklygoproject  
WORKDIR /go/src/github.com/bigphattoby/weeklygoproject  
COPY . .  
EXPOSE 3000  
CMD ["go run weekone.go"]  

