FROM elixir:1.4.2-slim

# RUN set -xe \
#     && apt-get update \
#     && apt-get install -y inotify-tools build-essential \
#     && rm -rf /var/lib/apt/lists/*

RUN mix local.hex --force && mix local.rebar --force

WORKDIR /var/app

ARG MIX_ENV=prod
ENV MIX_ENV $MIX_ENV

COPY config /var/app/config
COPY mix.exs /var/app/mix.exs
COPY mix.lock /var/app/mix.lock

RUN mix do deps.get, deps.compile

COPY lib /var/app/lib

RUN mix compile

CMD ["mix", "run", "--no-halt"]
