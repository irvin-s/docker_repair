FROM golang:1.11

EXPOSE 9000

ENV DEP_URL https://github.com/golang/dep/releases/download/v0.5.0/dep-linux-amd64

ENV DEP_HASH 287b08291e14f1fae8ba44374b26a2b12eb941af3497ed0ca649253e21ba2f83

RUN curl $DEP_URL -L -o $GOPATH/bin/dep && echo "$DEP_HASH $GOPATH/bin/dep" | sha256sum -c - && chmod 755 $GOPATH/bin/dep

RUN go get -u github.com/revel/cmd/revel

WORKDIR $GOPATH/src/github.com/magoo/www-forecast

COPY Gopkg.toml Gopkg.lock ./

RUN dep ensure --vendor-only

COPY . $GOPATH/src/github.com/magoo/www-forecast

RUN revel build github.com/magoo/www-forecast $GOPATH/bin/www-forecast prod

RUN chmod +x $GOPATH/bin/www-forecast

RUN rm -rf $GOPATH/src

CMD $GOPATH/bin/www-forecast/run.sh
