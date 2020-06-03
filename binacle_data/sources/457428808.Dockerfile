FROM alpine
RUN apk add --no-cache ca-certificates && update-ca-certificates

ENV HTTP_USER "admin"
ENV HTTP_PASSWORD "super secret"
ENV LISTENING_ADDRESS "0.0.0.0"
ENV LISTENING_PORT "8080"

WORKDIR /app

ADD ./templates ./templates
ADD ./static ./static
COPY ./ssh-key-editor .

EXPOSE ${LISTENING_PORT}

CMD ["./ssh-key-editor"]
