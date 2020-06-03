FROM golang:1.6  
COPY . /go/src/github.com/camembertaulaitcrew/camembert-au-lait-crew  
WORKDIR /go/src/github.com/camembertaulaitcrew/camembert-au-lait-crew  
RUN go install -v ./cmd/calc-www  
CMD ["calc-www", "server"]  
EXPOSE 9000  

