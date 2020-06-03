FROM golang:alpine  
ADD . ./  
RUN go build -o main  
EXPOSE 8080  
ENTRYPOINT [ "/go/main" ]

