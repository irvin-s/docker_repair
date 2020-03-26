FROM golang:1 as builder

WORKDIR /go/src/helm-builder
COPY . .

RUN go build -o /helm-builder


FROM alpine:3.9

ARG GCLOUD_VERSION=251.0.0
ARG HELM_VERSION=v2.14.1

RUN apk --update --no-cache add python tar openssl wget ca-certificates
RUN mkdir -p /opt

# gcloud
RUN	wget -q https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GCLOUD_VERSION}-linux-x86_64.tar.gz && \
	tar -xvf google-cloud-sdk-${GCLOUD_VERSION}-linux-x86_64.tar.gz && \
	mv google-cloud-sdk /opt/google-cloud-sdk && \
	/opt/google-cloud-sdk/install.sh --usage-reporting=true --path-update=true && \
	rm -f google-cloud-sdk-${GCLOUD_VERSION}-linux-x86_64.tar.gz && \
	/opt/google-cloud-sdk/bin/gcloud components install --quiet kubectl && \
	rm -rf /opt/google-cloud-sdk/.install/.backup

# helm
RUN	wget -q https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz && \
	tar -xvf helm-${HELM_VERSION}-linux-amd64.tar.gz && \
	cp linux-amd64/helm /opt/google-cloud-sdk/bin/ && \
	chmod a+x /opt/google-cloud-sdk/bin/helm && \
	rm -rf helm-${HELM_VERSION}-linux-amd64.tar.gz linux-amd64

COPY --from=builder /helm-builder /opt/google-cloud-sdk/bin/

ENV PATH=$PATH:/opt/google-cloud-sdk/bin

ENTRYPOINT ["/opt/google-cloud-sdk/bin/helm-builder"]
