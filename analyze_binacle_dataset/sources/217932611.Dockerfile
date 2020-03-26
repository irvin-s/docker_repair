FROM cnsa/elixir-iconv:1.5.1
WORKDIR /build
ADD . /build
RUN cp /build/rel/config.exs /build/config.exs
CMD mix deps.get
