# Start with the "official" Elixir build (this simplifies quite a bit here).
# This uses the "official" Erlang build (right now at 19.2) 
# on top of Debian jessie.
FROM elixir:1.4.0

MAINTAINER Your Name <name@your-domain.com>

ENV REFRESHED_AT 2017-01-15
# 2017-01-15 update to elixir 1.4.0

# Install hex
RUN /usr/local/bin/mix local.hex --force && \
    /usr/local/bin/mix local.rebar --force && \
    /usr/local/bin/mix hex.info

WORKDIR /app
COPY . .

RUN mix deps.get

CMD ["bash"]
   