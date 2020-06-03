FROM golang:1.9  
ARG ENV  
WORKDIR /go/src/app  
  
COPY . /go/src/app  
  
RUN go get -d -v ./...  
RUN go install -v ./...  
  
RUN if [ "${ENV}" = "dev" ]; then go get github.com/pilu/fresh; fi  
  
CMD app  
EXPOSE 80  

