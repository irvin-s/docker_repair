FROM golang:1.8.0-alpine
ENV PROJECT_DIR "$GOPATH/src/sitr.us/comparing-go-and-rust"
RUN mkdir -p "$PROJECT_DIR"
WORKDIR "$PROJECT_DIR"
COPY . "$PROJECT_DIR"
CMD ["go", "test", "./..."]
