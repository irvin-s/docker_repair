FROM golang:alpine  
  
RUN set -ex; \  
apk add --no-cache curl git && \  
curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh && \  
dep version  
  
WORKDIR /go/src/app  
  
ONBUILD COPY Gopkg.lock .  
ONBUILD COPY Gopkg.toml .  
ONBUILD RUN dep ensure -v -vendor-only  
  
ONBUILD COPY . .  
ONBUILD RUN go install -v ./...  
  
ENTRYPOINT ["app"]  

