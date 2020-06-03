FROM elixir:1.7.4

ENV MIX_ENV prod

WORKDIR /opt

RUN mix local.hex --force
RUN mix local.rebar --force

COPY . .
ENV HEX_UNSAFE_REGISTRY 1
RUN rm -rf deps
RUN rm -rf _build
RUN mix deps.get
RUN mix compile

CMD elixir --sname mcc_logic --cookie mcc_cluster -S mix run --no-halt
