# build stage  
FROM golang:latest  
RUN mkdir /src  
ADD app /src/  
WORKDIR /src  
RUN go get -u github.com/lib/pq  
RUN go get -u github.com/gorilla/mux  
RUN go get -u github.com/rs/zerolog/log  
RUN go get -u k8s.io/client-go/rest  
RUN go get -u k8s.io/client-go/tools/clientcmd  
RUN go get -u k8s.io/api/apps/v1  
RUN go get -u k8s.io/api/core/v1  
RUN go get -u k8s.io/apimachinery/pkg/apis/meta/v1  
RUN go get -u k8s.io/client-go/kubernetes  
RUN CGO_ENABLED=0 GOOS=linux go build -o main .  
  
# final stage  
FROM alpine  
WORKDIR /app  
COPY \--from=0 /src/main /app/  
CMD ["/app/main"]  
EXPOSE 8080

