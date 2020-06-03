FROM haskell:8.0.1

RUN apt-get update && \
    apt-get install -y --no-install-recommends libpq-dev

COPY . /var/confsinfo

WORKDIR /var/confsinfo
RUN stack --no-terminal build --install-ghc --copy-bins

CMD /root/.local/bin/confsinfo-backend-exe
