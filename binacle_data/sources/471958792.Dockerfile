# Compile
FROM golang:1.12-alpine AS compiler

RUN apk add --no-cache git
ARG URL_BRANCH
ARG CHARTMUSEUM_URL

# not in GOPATH, go modules auto enabled
WORKDIR /dccn-daemon
COPY . .

RUN CGO_ENABLED=0 go vet ./...
RUN CGO_ENABLED=0 go test -v $(go list ./... | grep -v task/kube)
RUN CGO_ENABLED=0 go build -v -ldflags="-s -w \
    -X main.version=$(git rev-parse --abbrev-ref HEAD) \
    -X main.commit=$(git rev-parse --short HEAD) \
    -X main.date=$(date +%Y-%m-%dT%H:%M:%S%z) \
    -X main.hubAddr=${URL_BRANCH} -X github.com/Ankr-network/dccn-daemon/task/kube.helmRepoPrefix=${CHARTMUSEUM_URL}" ./cmd/daemon

# Download helm
FROM alpine AS helm

RUN wget https://storage.googleapis.com/kubernetes-helm/helm-v2.14.0-linux-amd64.tar.gz -O- | tar xz

# Build image, alpine provides more possibilities than scratch
FROM alpine

RUN apk add --no-cache ca-certificates

COPY --from=compiler /dccn-daemon/daemon /daemon
RUN ln -s /daemon /usr/local/bin/daemon

COPY --from=helm /linux-amd64/helm /helm
RUN ln -s /helm /usr/local/bin/helm

CMD ["daemon","version"]
