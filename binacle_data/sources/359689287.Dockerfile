FROM msaraiva/elixir-dev:1.2.0

MAINTAINER Simone Mosciatti

ENV REFRESHED_AT V0.1.7

RUN git clone https://github.com/siscia/numerino.git numerino

WORKDIR /numerino

RUN git checkout v0.1.7

RUN mix local.hex --force && \
    mix local.rebar --force

RUN mix deps.get

RUN mix compile

EXPOSE 4000

EXPOSE 4369

EXPOSE 5000

