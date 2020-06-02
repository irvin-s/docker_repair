FROM golang:1.10-alpine

ENV PROJECT=public-people-api
COPY . /${PROJECT}-sources/

RUN apk --no-cache --virtual .build-dependencies add git curl \
  && ORG_PATH="github.com/Financial-Times" \
  && REPO_PATH="${ORG_PATH}/${PROJECT}" \
  && mkdir -p $GOPATH/src/${ORG_PATH} \
  # Linking the project sources in the GOPATH folder
  && ln -s /${PROJECT}-sources $GOPATH/src/${REPO_PATH} \
  && cd $GOPATH/src/${REPO_PATH} \
  && BUILDINFO_PACKAGE="${ORG_PATH}/${PROJECT}/vendor/${ORG_PATH}/service-status-go/buildinfo." \
  && VERSION="version=$(git describe --tag --always 2> /dev/null)" \
  && DATETIME="dateTime=$(date -u +%Y%m%d%H%M%S)" \
  && REPOSITORY="repository=$(git config --get remote.origin.url)" \
  && REVISION="revision=$(git rev-parse HEAD)" \
  && BUILDER="builder=$(go version)" \
  && LDFLAGS="-X '"${BUILDINFO_PACKAGE}$VERSION"' -X '"${BUILDINFO_PACKAGE}$DATETIME"' -X '"${BUILDINFO_PACKAGE}$REPOSITORY"' -X '"${BUILDINFO_PACKAGE}$REVISION"' -X '"${BUILDINFO_PACKAGE}$BUILDER"'" \
  && echo "Build flags: $LDFLAGS" \
  && echo "Fetching dependencies..." \
  && curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh \
  && $GOPATH/bin/dep ensure -vendor-only \
  && go build -ldflags="${LDFLAGS}" \
  && mv ${PROJECT} /${PROJECT} \
  && apk del .build-dependencies \
  && rm -rf $GOPATH /var/cache/apk/*

WORKDIR /

CMD [ "/public-people-api" ]