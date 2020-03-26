FROM golang:1.6.3  
RUN go get github.com/cloudfly/arsenal/cmd/arsenal  
  
EXPOSE 6041  
CMD arsenal daemon --data /var/arsenal  
  

