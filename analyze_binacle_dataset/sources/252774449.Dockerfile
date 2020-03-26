FROM golang:1.6  
# Should really use apt-get and check sources  
# But this was quick and easy  
RUN curl -sSL https://get.docker.com/ | sh  
  
RUN go get -u github.com/coreos/clair/contrib/analyze-local-images  
  
ENTRYPOINT ["/go/bin/analyze-local-images"]  
  
EXPOSE 9279  

