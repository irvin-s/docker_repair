# builder
FROM golang:1.12-alpine as builder

ENV HELM_VERSION="v2.13.1"

# Install dependencies
RUN apk add --update --no-cache ca-certificates tar wget

# Build helmi
WORKDIR /go/src/github.com/monostream/helmi/

COPY . .
RUN go build -ldflags "-s -w" -o helmi .

# Copy helm artefacts
WORKDIR /app/
RUN cp /go/src/github.com/monostream/helmi/helmi .
RUN rm -r /go/src/

# Download helm
RUN wget -nv -O- https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz | tar --strip-components=1 -zxf -


# runner
FROM alpine:3.9

RUN apk add --update --no-cache ca-certificates dumb-init

WORKDIR /app/

COPY --from=builder /app/ .

# Setup environment
ENV PATH "/app:${PATH}"

RUN addgroup -S helmi && \
    adduser -S -G helmi helmi && \
    chown -R helmi:helmi /app

USER helmi

RUN mkdir -p ~/.helm/repository/cache && \
    mkdir -p ~/.helm/repository/local && \
    mkdir -p ~/.helm/cache/archive && \
    mkdir -p ~/.helm/plugins && \
    mkdir -p ~/.helm/starters

COPY --chown=helmi:helmi repositories.yaml /home/helmi/.helm/repository/repositories.yaml

ENTRYPOINT ["dumb-init", "--"]

CMD ["helmi"]