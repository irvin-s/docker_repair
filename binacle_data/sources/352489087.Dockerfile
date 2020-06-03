FROM alpine:3.6 as builder

RUN apk add --update --no-cache ca-certificates wget
RUN wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip
RUN unzip ngrok-stable-linux-386.zip

FROM scratch
ADD ./ca-certificates.crt  /etc/ssl/certs/ca-certificates.crt
COPY --from=builder /ngrok /usr/bin/ngrok

ENTRYPOINT ["/usr/bin/ngrok"]
