FROM golang:1.11.1-alpine3.8

ENV TZ=Asia/Shanghai

RUN apk --update add git \
  && mkdir /usr/local/go/src/vendor/github.com \
  && cd /usr/local/go/src/vendor/github.com \
  && mkdir PuerkitoBio \
  && cd PuerkitoBio \
  && git clone https://github.com/PuerkitoBio/goquery \
  && cd /usr/local/go/src/vendor/github.com \
  && mkdir andybalholm \
  && cd andybalholm \
  && git clone https://github.com/andybalholm/cascadia \
  && cd /usr/local/go/src/vendor/github.com \
  && mkdir op \
  && cd op \
  && git clone https://github.com/op/go-logging \
  && cd /usr/local/go/src/vendor/ \
  && mkdir golang.org \
  && cd golang.org \
  && mkdir x \
  && cd x \
  && git clone https://github.com/golang/crypto \
  && git clone https://github.com/golang/net \
  && cd /usr/local/go/src/ \
  && git clone https://github.com/moyuanz/hahajing \
  && cd hahajing/ \
  && set GOARCH=amd64 \
  && set GOOS=linux \
  && go build

WORKDIR "/usr/local/go/src/hahajing"
EXPOSE 80
CMD ["nohup", "./hahajing", "server"]
