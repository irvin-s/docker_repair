FROM alpine

ADD jwtd-proxy /bin/jwtd-proxy

EXPOSE 8080

CMD ["/bin/jwtd-proxy"]
