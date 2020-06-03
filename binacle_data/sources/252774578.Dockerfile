FROM golang:1.10-alpine AS build  
COPY . /go/src/github.com/barpilot/node-labeler-operator/  
WORKDIR /go/src/github.com/barpilot/node-labeler-operator/  
RUN go build -o /bin/node-labeler-operator .  
  
FROM alpine:latest  
RUN apk --no-cache add ca-certificates  
COPY --from=build /bin/node-labeler-operator /bin/node-labeler-operator  
ENTRYPOINT ["/bin/node-labeler-operator"]  

