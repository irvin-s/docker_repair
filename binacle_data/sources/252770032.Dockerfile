FROM golang:1.8  
RUN curl https://glide.sh/get | sh  
  
COPY . /go/src/github.com/artshpakov/grapho/  
WORKDIR /go/src/github.com/artshpakov/grapho  
  
RUN glide install  
RUN cp config/config.toml.example config/config.toml  
RUN go build src/grapho.go  
ENTRYPOINT ./grapho  
  
VOLUME /var/log/grapho  
  
EXPOSE 3000  

