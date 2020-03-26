FROM elixir:1.5.2-slim
MAINTAINER Team Aegis <aegis@decisiv.com>

ENV DEBIAN_FRONTEND=noninteractive

RUN mkdir /app
WORKDIR /app
ADD . /app

RUN mix do local.hex --force, local.rebar -force, deps.get

ENTRYPOINT ["mix"]
CMD ["do" "compile", "test"]
