FROM golang:1.8.7-alpine3.6 AS build
RUN apk --update add curl
ENV KUBERNETES_VERSION="v1.9.3"
WORKDIR $GOPATH/src/github.com/logicmonitor/k8s-asg-lifecycle-manager
COPY ./ ./
RUN go build -o /asg-lifecycle-manager
RUN curl -L "https://storage.googleapis.com/kubernetes-release/release/${KUBERNETES_VERSION}/bin/linux/amd64/kubectl" -o /kubectl \
    && chmod +x /kubectl

FROM alpine:3.7
COPY --from=build /kubectl /usr/local/bin/kubectl
COPY --from=build /asg-lifecycle-manager /usr/local/bin/asg-lifecycle-manager
RUN apk --no-cache add ca-certificates
ENTRYPOINT [ "/usr/local/bin/asg-lifecycle-manager" ]
