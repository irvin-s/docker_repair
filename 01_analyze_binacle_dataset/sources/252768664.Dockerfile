FROM golang:1.10 as builder  
WORKDIR /go/src/topdog  
COPY . .  
RUN CGO_ENABLED=0 GOOS=linux go install  
  
FROM scratch  
LABEL Description="Who's the top dog?"  
  
COPY \--from=builder /go/bin/topdog /topdog  
COPY \--from=builder /go/src/topdog/static /static  
WORKDIR /  
  
# Needed to know what port to listen on  
ENV SERVICE_PORT=5000  
EXPOSE 5000/tcp  
  
CMD ["/topdog", "-static", "/static"]  

