FROM golang:latest  
  
RUN go get -u -v github.com/spf13/hugo  
  
RUN mkdir /code  
ADD . /code  
WORKDIR /code  
  
ENTRYPOINT ["hugo"]  

