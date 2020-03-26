FROM golang:stretch AS build

# install dependencies
RUN echo 'deb http://deb.nodesource.com/node_10.x stretch main' >>/etc/apt/sources.list
RUN wget -qO- https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
RUN apt-get update && apt-get install -y jq nodejs build-essential git
RUN npm i npm@latest -g

# enable totally static binaries
ENV CGO_ENABLED "0"

# needed so we can mkdir in the scratch container later
RUN mkdir /tmp/emptydir

# get a shell
RUN mkdir /tmp/bin
ADD https://busybox.net/downloads/binaries/1.27.1-i686/busybox_ASH /tmp/bin/sh
RUN chmod +x /tmp/bin/sh

COPY . /go/src/github.com/supergiant/capacity/

# build the UI
WORKDIR /go/src/github.com/supergiant/capacity/cmd/capacity-service/ui/capacity-service
RUN npm install
RUN npm install -g @angular/cli
RUN npm rebuild node-sass
RUN ng build --prod --base-href="../ui/"

# download packr
RUN go get -u github.com/gobuffalo/packr/packr

ARG GIT_VERSION=none
ARG GIT_COMMIT=none

# Put pre-built ui back in place
WORKDIR /go/src/github.com/supergiant/capacity/cmd/capacity-service
RUN packr build -v -o /tmp/bin/capacity-service -ldflags="-s -w \
    -X github.com/supergiant/capacity/pkg/version.gitVersion=${GIT_VERSION} \
    -X github.com/supergiant/capacity/pkg/version.gitCommit=${GIT_COMMIT} \
    -X github.com/supergiant/capacity/pkg/version.buildDate=$(date -u +'%Y-%m-%dT%H:%M:%SZ')"

# build final container
FROM scratch
ENV PATH "/bin"
ENV SSL_CERT_FILE "/etc/ca-certificates.crt"
COPY --from=build /tmp/emptydir /etc
COPY --from=build /tmp/emptydir /etc/capacity-service
COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/
COPY --from=build /tmp/bin /bin
CMD /bin/capacity-service
