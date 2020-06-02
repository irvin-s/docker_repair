FROM golang:1.10 AS build-env  
RUN go get github.com/gorilla/mux && \  
go get github.com/gorilla/handlers && \  
go get github.com/kelseyhightower/envconfig && \  
go get github.com/go-pg/pg && \  
go get github.com/nlopes/slack && \  
go get github.com/hashicorp/go-retryablehttp && \  
go get github.com/go-ozzo/ozzo-validation && \  
go get github.com/go-ozzo/ozzo-validation/is && \  
go get github.com/lib/pq  
  
  
ADD . /go/src/github.com/clintjedwards/lgts  
WORKDIR /go/src/github.com/clintjedwards/lgts  
  
RUN GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o /src/lgts  
  
FROM alpine  
WORKDIR /app  
RUN apk update && apk add ca-certificates  
COPY --from=build-env /src/lgts /app/  
ENTRYPOINT ["./lgts"]  

