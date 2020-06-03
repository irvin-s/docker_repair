FROM golang:latest AS buildStage
WORKDIR /go/src/diydashboard
COPY . .
RUN CGO_ENABLED=0 go get github.com/christophberger/grada
RUN CGO_ENABLED=0 go build

FROM scratch
MAINTAINER chris@appliedgo.net
WORKDIR /app
COPY --from=buildStage /go/src/diydashboard/diydashboard .
ENTRYPOINT ["/app/diydashboard"]