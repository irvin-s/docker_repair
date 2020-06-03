FROM elixir:latest

RUN mix local.hex --force
RUN mix local.rebar --force

WORKDIR /app

COPY . .
