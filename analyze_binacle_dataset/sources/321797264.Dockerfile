FROM coredns/coredns:latest
COPY Corefile /
EXPOSE 53 53/udp
ENTRYPOINT ["/coredns"]
