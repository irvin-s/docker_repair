FROM alpine:3.1  
COPY ./app.go /app.go  
  
RUN apk --update add go && \  
go build -o /app /app.go && \  
rm /app.go && \  
apk del go  
  
ENTRYPOINT ["/app"]  

