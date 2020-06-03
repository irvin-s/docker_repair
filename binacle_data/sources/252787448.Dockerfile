FROM golang:alpine  
LABEL maintainer "Alex Simenduev <shamil@bringg.com>"  
  
RUN mkdir -p /go/src/app  
WORKDIR /go/src/app  
COPY . /go/src/app  
  
RUN apk --no-cache add git \  
&& go-wrapper download \  
&& go-wrapper install \  
&& rm -Rf /go/{pkg,src} \  
&& apk del git  
  
USER nobody  
ENTRYPOINT ["go-wrapper", "run"]  
CMD ["-help"]  

