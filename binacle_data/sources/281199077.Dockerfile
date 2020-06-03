FROM golang:1.10-alpine3.7 as builder

RUN apk add --no-cache --virtual .build-deps upx curl git && \
    curl -fsSL -o /usr/local/bin/dep https://github.com/golang/dep/releases/download/v0.4.1/dep-linux-amd64 && \
    chmod +x /usr/local/bin/dep

WORKDIR /go/src/github.com/saracen/navigator

COPY Gopkg.toml Gopkg.lock ./

RUN dep ensure -vendor-only
RUN go get github.com/itchio/gothub

COPY . ./

RUN go test -coverprofile coverage.txt -covermode atomic ./...
RUN CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -ldflags="-s -w" -a -installsuffix cgo -o navigator-darwin-amd64 .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -a -installsuffix cgo -o navigator-linux-amd64 .
RUN CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -ldflags="-s -w" -a -installsuffix cgo -o navigator-windows-amd64.exe .
RUN upx ./navigator-*

FROM golang:1.10-alpine3.7 as releaser

ARG GITHUB_TOKEN
ARG GIT_USERNAME
ARG GIT_REPOSITORY
ARG SOURCE_BRANCH
ARG CODECOV_TOKEN

RUN apk add --no-cache --virtual .build-deps curl bash git

COPY ./.git ./
COPY --from=builder /go/src/github.com/saracen/navigator/coverage.txt ./
RUN curl -s -o ./.codecov https://codecov.io/bash && \
    chmod +x ./.codecov && \
    ./.codecov -X gcov -X coveragepy -X xcode -X fix -X search -f coverage.txt

COPY --from=builder /go/bin/gothub ./
RUN ./gothub release --user $GIT_USERNAME --repo $GIT_REPOSITORY --tag $SOURCE_BRANCH --name $SOURCE_BRANCH --draft

COPY --from=builder /go/src/github.com/saracen/navigator/navigator-darwin-amd64 ./
COPY --from=builder /go/src/github.com/saracen/navigator/navigator-linux-amd64 ./
COPY --from=builder /go/src/github.com/saracen/navigator/navigator-windows-amd64.exe ./

RUN ./gothub upload --user $GIT_USERNAME --repo $GIT_REPOSITORY --tag $SOURCE_BRANCH --name "navigator-darwin-amd64" --file ./navigator-darwin-amd64 --replace
RUN ./gothub upload --user $GIT_USERNAME --repo $GIT_REPOSITORY --tag $SOURCE_BRANCH --name "navigator-linux-amd64" --file ./navigator-linux-amd64 --replace
RUN ./gothub upload --user $GIT_USERNAME --repo $GIT_REPOSITORY --tag $SOURCE_BRANCH --name "navigator-windows-amd64.exe" --file ./navigator-windows-amd64.exe --replace

FROM scratch as dockerimage
COPY --from=builder /etc/ssl/certs/ /etc/ssl/certs/
COPY --from=builder /go/src/github.com/saracen/navigator/navigator-linux-amd64 ./navigator

ENTRYPOINT ["./navigator"]
