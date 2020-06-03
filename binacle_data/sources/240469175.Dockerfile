# Generated automatically by update.sh
# Do no edit this file

FROM bigtruedata/scala:2.12.0

Run wget -O- "https://github.com/sbt/sbt/releases/download/v0.13.15/sbt-0.13.15.tgz" \
    |  tar xzf - -C /usr/local --strip-components=1 \
    && sbt exit

VOLUME /app
WORKDIR /app

CMD ["sbt"]
