FROM fpco/pid1:0.1.2.0

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    ca-certificates \
    zlib1g-dev \
    libgmp-dev \
    netbase

RUN mkdir -p /opt/app

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

COPY build/hfp /opt/app/hfp
COPY static /opt/app/static
COPY config /opt/app/config
COPY content /opt/app/content


WORKDIR /opt/app

CMD ["/opt/app/hfp"]
