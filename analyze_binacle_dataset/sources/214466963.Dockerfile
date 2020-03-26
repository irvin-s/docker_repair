FROM jvoigtlaender/elm:0.15

EXPOSE 3000
ENV CODENVY_APP_PORT_80_HTTP 3000

RUN mkdir /application
ENV CODENVY_APP_BIND_DIR /application

WORKDIR /application

CMD elm-package install --yes && elm-make && elm-reactor --port=3000

