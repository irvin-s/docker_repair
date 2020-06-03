FROM alpine:3.3
ADD checkAlive.sh /root/checkAlive.sh
RUN apk --update add bash
RUN apk --update add jq
RUN apk --update add docker

ENTRYPOINT ["bash", "/root/checkAlive.sh"]
