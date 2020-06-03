FROM golang:1.7  
RUN mkdir -p /go/src/dynct  
WORKDIR /go/src/dynct  
COPY . /go/src/dynct  
RUN curl https://glide.sh/get | sh  
RUN glide install && go install  
CMD ["go-wrapper", "run"]  

