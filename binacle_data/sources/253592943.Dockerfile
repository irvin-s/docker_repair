FROM alpine:3.3

ADD sleep.sh .

ENTRYPOINT ["sh", "sleep.sh"]
