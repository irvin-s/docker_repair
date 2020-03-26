FROM debian:stretch
RUN apt-get update -qq && apt-get install -y graphviz --no-install-recommends && rm -rf /var/lib/apt/lists/*
