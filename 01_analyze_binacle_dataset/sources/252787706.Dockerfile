FROM golang:1.7  
RUN mkdir -p /frozen  
  
WORKDIR /frozen  
  
ADD . /frozen  
  
RUN go build ./main.go  
  
CMD ["./frozen"]

