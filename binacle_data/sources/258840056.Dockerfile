FROM alpine:3.4

COPY ./build/scalar /

CMD ["/scalar"]