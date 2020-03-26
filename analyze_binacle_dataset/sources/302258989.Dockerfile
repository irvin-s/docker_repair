FROM alpine:3.2
ADD book-server-v2 /book-server-v2
ENTRYPOINT [ "/book-server-v2" ]
