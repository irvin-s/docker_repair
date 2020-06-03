FROM golang:1.10  
WORKDIR /go/src/github.com/ashiddo11/k8s-custom-hpa/  
  
RUN go get gopkg.in/yaml.v2 k8s.io/client-go/...  
  
COPY . .  
  
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o custom-hpa .  
  
FROM scratch  
  
COPY \--from=0 /go/src/github.com/ashiddo11/k8s-custom-hpa/custom-hpa /  
  
CMD ["/custom-hpa"]  

