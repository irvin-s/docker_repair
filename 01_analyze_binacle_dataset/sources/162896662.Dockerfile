FROM golang:1.5
EXPOSE 80

RUN wget https://github.com/erasche/barcode-server/archive/07b397b0fa08f6d0e2bd3017a25ba30835ecf8aa.tar.gz && \
    tar xvfz 07b397b0fa08f6d0e2bd3017a25ba30835ecf8aa.tar.gz && \
    mv barcode-server-07b397b0fa08f6d0e2bd3017a25ba30835ecf8aa/ /app/ && \
    go get -v github.com/codegangsta/cli && \
    go get -v github.com/boombuler/barcode && \
    go get -v github.com/gorilla/mux && \
    go get -v github.com/gorilla/handlers

CMD ["go" "run" "/app/main.go", "-l", "0.0.0.0:80"]
