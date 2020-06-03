# Generated automatically by update.sh
# Do no edit this file

FROM bigtruedata/scala:2.11.7

Run wget -O- "https://github.com/sbt/sbt/releases/download/v1.0.2/sbt-1.0.2.tgz" \
    |  tar xzf - -C /usr/local --strip-components=1 \
    && sbt exit

VOLUME /app
WORKDIR /app

CMD ["sbt"]
