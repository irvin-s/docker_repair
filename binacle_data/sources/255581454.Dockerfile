FROM scratch
MAINTAINER Tom Verelst <tom.verelst@ordina.be>
EXPOSE 8080

ADD build/main /

ENTRYPOINT ["/main"]
