FROM alpine
MAINTAINER deepzz <deepzz.qi@gmail.com>

RUN apk update
RUN apk add ca-certificates
ENV MGO 192.168.0.1
ADD conf/Shanghai /etc/localtime
ADD views /goblog/views
ADD conf /goblog/conf
ADD static /goblog/static
ADD goblog /goblog/goblog
ADD version /goblog/version

EXPOSE 80

VOLUME ["/goblog/log"]

WORKDIR /goblog
ENTRYPOINT ["./goblog"] 
