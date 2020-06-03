FROM alpine:3.2
ADD book-server-web /book-server-web
ENTRYPOINT [ "/book-server-web" ]
