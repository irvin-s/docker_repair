FROM debian

RUN apt-get update && apt-get install -y cowsay

ENTRYPOINT ["/usr/games/cowsay"]
