FROM golang:1.7.5  
  
RUN go get github.com/dgrijalva/jwt-go && \  
go get github.com/elithrar/simple-scrypt && \  
go get github.com/golang/protobuf/proto && \  
go get github.com/jinzhu/gorm && \  
go get github.com/jinzhu/gorm/dialects/sqlite && \  
go get github.com/jmcvetta/randutil && \  
go get github.com/lib/pq && \  
go get github.com/lib/pq/hstore && \  
go get github.com/metal3d/go-slugify && \  
go get github.com/nfnt/resize && \  
go get github.com/minio/minio-go && \  
go get github.com/pquerna/otp && \  
go get github.com/satori/go.uuid && \  
go get github.com/Sirupsen/logrus && \  
go get github.com/stretchr/testify/suite && \  
go get golang.org/x/net/context && \  
go get golang.org/x/oauth2 && \  
go get golang.org/x/oauth2/facebook && \  
go get golang.org/x/oauth2/google && \  
go get golang.org/x/oauth2/linkedin && \  
go get google.golang.org/grpc && \  
go get google.golang.org/grpc/peer && \  
go get google.golang.org/grpc/reflection  
  
ADD app $GOPATH/src/github.com/codequest-eu/startupinabox/golang/app  
ADD stubs $GOPATH/src/github.com/codequest-eu/startupinabox/golang/stubs  
WORKDIR $GOPATH/src/github.com/codequest-eu/startupinabox/golang/app  
RUN go build -o /startupinabox/app  
EXPOSE 1983  
CMD ["/startupinabox/app"]  

