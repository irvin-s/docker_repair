FROM alpine:3.1  
COPY /replicator.go /replicator.go  
  
RUN apk --update add go && \  
go build -o /http-replicator /replicator.go && \  
apk del go  
  
ENTRYPOINT ["/http-replicator"]  

