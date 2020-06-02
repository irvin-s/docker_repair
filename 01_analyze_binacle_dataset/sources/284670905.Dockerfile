FROM fpco/pid1

RUN mkdir -p /opt/app
WORKDIR /opt/app

RUN apt-get update && apt-get install -y \
  ca-certificates \
  libgmp-dev

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

