FROM golang:1.8
ADD ./testdata/config.json /shadowsocks/config.json
RUN go get -v github.com/cssivision/shadowsocks/cmd/ssserver
WORKDIR /shadowsocks
EXPOSE 8089
CMD ["ssserver", "-c", "config.json"]