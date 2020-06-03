FROM alpine

ADD _output/bin/kenc /usr/local/bin

RUN apk --no-cache --update add iptables

CMD ["/usr/local/bin/kenc"]
