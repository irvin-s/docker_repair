FROM golang:1.9 as dep
RUN go get -u github.com/golang/dep/cmd/dep
RUN go get -u github.com/alecthomas/gometalinter
RUN gometalinter --install
RUN go get -u github.com/golang/mock/gomock
RUN go get -u github.com/golang/mock/mockgen
WORKDIR /go/src/github.com/MYOB-Technology/ops-kube-db-operator
COPY ./Gopkg.lock ./Gopkg.toml ./
RUN dep ensure -vendor-only
# Pre cache the image by running go install need to copy in main.go and pkg dir to do this
COPY ./main.go ./
COPY ./pkg ./pkg
RUN go install -v

FROM golang:1.9 as builder
COPY --from=dep /go/bin/dep /go/bin/dep
WORKDIR /go/src/github.com/MYOB-Technology/ops-kube-db-operator
COPY . /go/src/github.com/MYOB-Technology/ops-kube-db-operator
RUN dep ensure -v
ARG VERSION=latest
RUN CGO_ENABLED=0 go build -o /build/postgres-operator -ldflags "-X main.version=$VERSION" -v

FROM scratch
COPY --from=builder /build/postgres-operator /app
ENTRYPOINT [ "/app", "--logtostderr=true"]
