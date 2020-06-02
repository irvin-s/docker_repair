FROM alpine:3.4

ADD long-running.sh /long-running.sh

ENTRYPOINT ["/long-running.sh"]
