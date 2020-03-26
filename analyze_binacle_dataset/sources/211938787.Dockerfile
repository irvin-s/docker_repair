FROM alpine:3.3
RUN apk --update add iperf

EXPOSE 5001
