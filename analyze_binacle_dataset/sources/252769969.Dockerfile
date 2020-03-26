FROM golang:latest  
  
WORKDIR /go/src/app  
COPY . .  
  
RUN go get -d -v ./...  
RUN go install -v ./...  
  
RUN go build -o main .  
  
EXPOSE 8080  
ENTRYPOINT ./main  

