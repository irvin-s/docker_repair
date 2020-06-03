FROM msaraiva/erlang:18.1

RUN apk --update add erlang-crypto erlang-sasl && rm -rf /var/cache/apk/*

ENV APP_NAME fast_ts
ENV APP_VERSION "0.0.1"
ENV PORT 5555
ENV FTS_ROUTE_DIR /$APP_NAME/routes

RUN mkdir -p /$APP_NAME
ADD rel/$APP_NAME/bin /$APP_NAME/bin
ADD rel/$APP_NAME/lib /$APP_NAME/lib
ADD rel/$APP_NAME/releases/start_erl.data                 /$APP_NAME/releases/start_erl.data
ADD rel/$APP_NAME/releases/$APP_VERSION/$APP_NAME.boot    /$APP_NAME/releases/$APP_VERSION/$APP_NAME.boot
ADD rel/$APP_NAME/releases/$APP_VERSION/$APP_NAME.rel     /$APP_NAME/releases/$APP_VERSION/$APP_NAME.rel
ADD rel/$APP_NAME/releases/$APP_VERSION/$APP_NAME.script  /$APP_NAME/releases/$APP_VERSION/$APP_NAME.script
ADD rel/$APP_NAME/releases/$APP_VERSION/$APP_NAME.sh     /$APP_NAME/releases/$APP_VERSION/$APP_NAME.sh
ADD rel/$APP_NAME/releases/$APP_VERSION/start.boot        /$APP_NAME/releases/$APP_VERSION/start.boot
ADD rel/$APP_NAME/releases/$APP_VERSION/sys.config        /$APP_NAME/releases/$APP_VERSION/sys.config
ADD rel/$APP_NAME/releases/$APP_VERSION/vm.args           /$APP_NAME/releases/$APP_VERSION/vm.args

RUN mkdir -p /$APP_NAME/routes
ADD config/routes/route.exs /$APP_NAME/routes/route.exs

EXPOSE $PORT

CMD trap exit TERM; /$APP_NAME/bin/$APP_NAME foreground & wait