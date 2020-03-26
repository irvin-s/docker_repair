FROM debian:stretch

RUN apt-get update && apt-get install --yes --quiet daemontools imapfilter
