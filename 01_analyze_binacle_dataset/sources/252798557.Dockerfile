FROM golang:1.6  
RUN go-wrapper download github.com/Masterminds/glide \  
&& go-wrapper install github.com/Masterminds/glide  
  
RUN mkdir -p /go/src/github.com/depsio/parsers/go-glide  
WORKDIR /go/src/github.com/depsio/parsers/go-glide  
  
COPY . /go/src/github.com/depsio/parsers/go-glide  
RUN glide install && go-wrapper install  
  
CMD ["go-wrapper", "run"]  

