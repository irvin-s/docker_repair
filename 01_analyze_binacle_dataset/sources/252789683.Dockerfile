FROM golang:latest  
ENV HOME=/root  
RUN go get github.com/dvdmuckle/twitter-trivia-bot  
WORKDIR "/root"  
ENTRYPOINT ["/go/bin/twitter-trivia-bot"]  

