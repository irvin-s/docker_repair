FROM alpine:3.8 as build-env
RUN apk update && \
      apk add rust cargo  libressl-dev libgcc

WORKDIR /usr/app
COPY . .

RUN cargo build --release
RUN cp -rf ./target/release/pg-dispatcher /usr/local/bin/

FROM alpine:3.8
RUN apk update && apk add libressl-dev libgcc

COPY --from=build-env /usr/app/target/release/pg-dispatcher /usr/local/bin/
