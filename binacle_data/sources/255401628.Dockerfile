FROM elixir:1.3-slim
WORKDIR /build
RUN mix local.hex --force
RUN mix local.rebar --force
ADD . /build
RUN cp /build/rel/config.exs config.exs

