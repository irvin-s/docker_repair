FROM golang:1.10.0-alpine3.7  
RUN apk --no-cache add git make bash chromium  
  
RUN mkdir -p src/github.com/jamesbcook/  
  
WORKDIR src/github.com/jamesbcook/  
  
RUN git clone https://github.com/jamesbcook/peepingJim.git  
  
WORKDIR peepingJim  
  
RUN make docker  
  
WORKDIR bin  
  
CMD ["./peepingJim", "-h"]

