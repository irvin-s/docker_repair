FROM play-hello

ENTRYPOINT cd /opt/scala-play-hello ; sbt "run 9901"