FROM golang:latest  
  
WORKDIR /go/src/github.com/denniswebb/base64sha256  
  
COPY . .  
  
RUN ./build.sh  
  
FROM scratch  
  
COPY \--from=0 /go/src/github.com/denniswebb/base64sha256/build/app /app  
  
ENTRYPOINT ["/app"]  

