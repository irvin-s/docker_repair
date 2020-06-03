# Install and run yarn

FROM gcr.io/google-appengine/debian8 AS static

# Install updates and dependencies
RUN apt-get update -y && apt-get install --no-install-recommends -y -q curl python build-essential git ca-certificates libkrb5-dev imagemagick && \
    apt-get clean && rm /var/lib/apt/lists/*_*

# Install the latest LTS release of nodejs
RUN mkdir /nodejs && curl https://nodejs.org/dist/v8.12.0/node-v8.12.0-linux-x64.tar.xz | tar xvJf - -C /nodejs --strip-components=1
ENV PATH $PATH:/nodejs/bin

# Install the latest stable release of Yarn
RUN mkdir /yarn && curl -L https://github.com/yarnpkg/yarn/releases/download/v1.9.4/yarn-v1.9.4.tar.gz | tar xvzf - -C /yarn --strip-components=1
ENV PATH $PATH:/yarn/bin

COPY /frontend /frontend

RUN cd frontend && yarn
RUN cd frontend && yarn run build

# Build Go app, install cockroach

FROM golang:1.11-alpine AS go
COPY . /go/src/website
RUN go install website

# Build final image

FROM alpine:3.7
# Add ssl certs for Go
RUN apk add --no-cache ca-certificates
COPY hots.json /
ENV GOOGLE_APPLICATION_CREDENTIALS /hots.json
COPY aws.creds /root/.aws/credentials
COPY --from=static /frontend/build /static
COPY --from=go /go/bin/website /website
ENTRYPOINT ["/website"]
