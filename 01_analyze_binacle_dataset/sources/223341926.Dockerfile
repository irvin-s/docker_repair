FROM golang:1.11.2-alpine3.7
MAINTAINER Xue Bing <xuebing1110@gmail.com>

# repo
RUN cp /etc/apk/repositories /etc/apk/repositories.bak
RUN echo "http://mirrors.aliyun.com/alpine/v3.7/main/" > /etc/apk/repositories
RUN echo "http://mirrors.aliyun.com/alpine/v3.7/community/" >> /etc/apk/repositories

# timezone
RUN apk update
RUN apk add --no-cache tzdata \
    && echo "Asia/Shanghai" > /etc/timezone \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# move to GOPATH
RUN mkdir -p /go/src/github.com/xuebing1110/rtbus
COPY . $GOPATH/src/github.com/xuebing1110/rtbus/
WORKDIR $GOPATH/src/github.com/xuebing1110/rtbus


# build
RUN mkdir -p /app
RUN go build -o /app/rtbus cmd/main.go

WORKDIR /app
EXPOSE 8080
CMD ["/app/rtbus"]
