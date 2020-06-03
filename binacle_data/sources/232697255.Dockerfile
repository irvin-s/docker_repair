FROM alpine:3.4

RUN apk add --no-cache openssl go git curl nodejs python build-base &&\
    export GOPATH=/ &&\
    git clone --depth=1 --branch v3.1.1 https://github.com/grafana/grafana.git /src/github.com/grafana/grafana &&\
    rm -r /src/github.com/grafana/grafana/.git &&\
    cd /src/github.com/grafana/grafana &&\
    go run build.go setup &&\
    go run build.go build &&\
    npm install &&\
    npm install -g grunt-cli &&\
    sed -i '13s/^  \*/  /' public/sass/components/_dropdown.scss &&\
    grunt &&\
    mkdir -p /usr/share/grafana/bin &&\
    cp -a /src/github.com/grafana/grafana/bin/grafana-server /usr/share/grafana/bin &&\
    cp -ra /src/github.com/grafana/grafana/public_gen /usr/share/grafana &&\
    mv /usr/share/grafana/public_gen /usr/share/grafana/public &&\
    cp -ra /src/github.com/grafana/grafana/conf /usr/share/grafana &&\
    npm uninstall -g grunt-cli && apk del --purge build-base nodejs go git python openssl &&\
    rm -rf /src /root/node-gyp /root/.npm /tmp/*

WORKDIR /usr/share/grafana/

VOLUME /usr/share/grafana/conf /usr/share/grafana/data

EXPOSE 3000

ADD run.sh /

ENTRYPOINT ["/run.sh"]
