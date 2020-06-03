FROM golang:1.10  
RUN mkdir /app  
ADD . /app/  
WORKDIR /app  
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o load .  
  
FROM alpine:latest  
RUN apk --no-cache add ca-certificates  
WORKDIR /root/  
COPY \--from=0 /app/load .  
ENTRYPOINT ["./load"]  
CMD ["-h"]  

