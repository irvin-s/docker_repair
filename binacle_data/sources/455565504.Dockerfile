FROM alpine:latest

ADD config*.ini lifx.py pophttp.py README.md /pophttp/
RUN apk add --no-cache python3

EXPOSE 56700/udp

WORKDIR /pophttp
ENTRYPOINT ["/usr/bin/python3", "/pophttp/pophttp.py"]
