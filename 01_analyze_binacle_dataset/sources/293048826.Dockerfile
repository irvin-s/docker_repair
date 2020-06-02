FROM alpine:edge AS development
RUN apk add --no-cache gcc musl-dev rust cargo openssl-dev

ENV APP_HOME /tmp/datadog-sidekiq
RUN mkdir -p $APP_HOME/src
WORKDIR $APP_HOME

COPY Cargo.toml $APP_HOME
COPY src $APP_HOME/src
RUN cargo build --release

FROM alpine:edge
RUN apk add --no-cache openssl gcc

COPY --from=development /tmp/datadog-sidekiq/target/release/datadog-sidekiq /usr/bin/

CMD /usr/bin/datadog-sidekiq
