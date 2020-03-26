FROM haskell:8

ADD . /build
RUN cd build && stack install

ENTRYPOINT ["/root/.local/bin/market-switch"]
