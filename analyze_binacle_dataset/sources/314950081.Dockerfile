FROM golang:1.10 as tester
WORKDIR /go/src/github.com/operator-framework/operator-manifests
COPY . .
RUN go test ./cmd/catalogbuilder
RUN go get github.com/operator-framework/operator-lifecycle-manager/cmd/validator
RUN wget -P ./deploy/chart/templates https://raw.githubusercontent.com/operator-framework/operator-lifecycle-manager/master/deploy/chart/templates/0000_30_05-catalogsource.crd.yaml
RUN wget -P ./deploy/chart/templates https://raw.githubusercontent.com/operator-framework/operator-lifecycle-manager/master/deploy/chart/templates/0000_30_02-clusterserviceversion.crd.yaml
RUN validator ./manifests

FROM golang:1.10 as builder
WORKDIR /go/src/github.com/operator-framework/operator-manifests
COPY cmd cmd
RUN go build -o bin/catalogbuilder ./cmd/catalogbuilder
RUN chmod +x bin/catalogbuilder

FROM scratch
WORKDIR /
COPY --from=builder /go/src/github.com/operator-framework/operator-manifests/bin/catalogbuilder /catalogbuilder
COPY manifests /manifests
COPY operator-manifests.catalogsource.yaml operator-manifests.catalogsource.yaml
COPY operator-manifests.configmap.yaml operator-manifests.configmap.yaml

CMD ["/catalogbuilder"]
