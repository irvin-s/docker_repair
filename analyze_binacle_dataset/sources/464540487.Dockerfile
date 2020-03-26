FROM alpine:latest
ADD entrypoint.sh /
ENTRYPOINT ["sh", "/entrypoint.sh"]