FROM golang:latest  
RUN mkdir restv2  
ADD . restv2/  
ADD .phonebookrc restv2/  
  
WORKDIR restv2  
RUN go get github.com/julienschmidt/httprouter  
RUN go get github.com/lib/pq  
RUN go get github.com/FogCreek/mini  
RUN go build -o main .  
  
CMD ["/go/restv2/main"]

