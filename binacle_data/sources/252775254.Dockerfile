FROM golang:1.8.3-alpine  
RUN apk --no-cache update && \  
apk --no-cache add ca-certificates && \  
rm -rf /var/cache/apk/*  
COPY . /go/src/github.com/BeenVerifiedInc/bvents-drone  
WORKDIR /go/src/github.com/BeenVerifiedInc/bvents-drone  
ENV CGO_ENABLED 0  
RUN go build -installsuffix cgo -o /app/bvents-drone  
ENTRYPOINT ["/app/bvents-drone"]  

