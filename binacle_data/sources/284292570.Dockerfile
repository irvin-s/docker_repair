FROM stellar/base:latest

# 5432 - postgres
# 8000 - horizon https://github.com/stellar/go/tree/master/services/horizon
# 8004 - friendbot https://github.com/stellar/go/tree/master/services/friendbot
# 8006 - bridge server https://github.com/stellar/go/tree/master/services/bridge
# 11625 - stellar core peer port
# 11626 - stellar core command port
EXPOSE 5432 8000 8004 8006 11625 11626

RUN echo "[start: dependencies]" \
    && apt-get update \
    && apt-get install -y \
        curl git libpq-dev libsqlite3-dev libsasl2-dev postgresql-client postgresql postgresql-contrib sudo vim zlib1g-dev supervisor \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && echo "[end: dependencies]"


ENV STELLAR_CORE_VERSION 10.0.0-685-1fc018b4
ENV HORIZON_VERSION 0.15.1

# Install core and horizon
RUN echo "[start: stellar install]" \
    && wget -O stellar-core.deb https://s3.amazonaws.com/stellar.org/releases/stellar-core/stellar-core-${STELLAR_CORE_VERSION}_amd64.deb \
    && dpkg -i stellar-core.deb \
    && rm stellar-core.deb \
    && wget -O horizon.tar.gz https://github.com/stellar/go/releases/download/horizon-v${HORIZON_VERSION}/horizon-v${HORIZON_VERSION}-linux-amd64.tar.gz \
    && tar -zxvf horizon.tar.gz \
    && mv /horizon-v${HORIZON_VERSION}-linux-amd64/horizon /usr/local/bin \
    && chmod +x /usr/local/bin/horizon \
    && rm -rf horizon.tar.gz /horizon-v${HORIZON_VERSION}-linux-amd64 \
    && echo "[end: stellar install]"

# Install stellar bridge server
ENV BRIDGE_VERSION 0.0.31
RUN echo "[start: installing stellar bridge]" \
    && mkdir -p /opt/stellar/bridge \
    && curl -L https://github.com/stellar/bridge-server/releases/download/v${BRIDGE_VERSION}/bridge-v${BRIDGE_VERSION}-linux-amd64.tar.gz \
        | tar -xz -C /opt/stellar/bridge --strip-components=1 \
    && echo "[end: installing stellar bridge"

ADD common          /opt/stellar-default/common
# Public network
ADD pubnet          /opt/stellar-default/pubnet
# Test network
ADD testnet         /opt/stellar-default/testnet
# Private integration testing network with a single node and fixtures
ADD integrationnet  /opt/stellar-default/integrationnet

ADD start /

RUN echo "[start: configuring paths and users]" \
    && useradd --uid 10011001 --home-dir /home/stellar --no-log-init stellar \
    && mkdir -p /home/stellar \
    && chown -R stellar:stellar /home/stellar \
    && mkdir -p /opt/stellar \
    && touch /opt/stellar/.docker-ephemeral \
    && ln -s /opt/stellar /stellar \
    && ln -s /opt/stellar/core/etc/stellar-core.cfg /stellar-core.cfg \
    && ln -s /opt/stellar/horizon/etc/horizon.env /horizon.env \
    && chmod +x /start \
    && echo "[end: configuring paths and users]"

# Install friendbot
ENV FRIENDBOT_VERSION 0.0.1
RUN echo "[start: friendbot install]" \
    && wget -O friendbot.tar.gz https://github.com/stellar/go/releases/download/friendbot-v${FRIENDBOT_VERSION}/friendbot-v${FRIENDBOT_VERSION}-linux-amd64.tar.gz \
    && tar xf friendbot.tar.gz --to-stdout friendbot-v${FRIENDBOT_VERSION}-linux-amd64/friendbot > /opt/stellar-default/common/friendbot/friendbot \
    && chmod a+x /opt/stellar-default/common/friendbot/friendbot \
    && echo "[end: friendbot install]"

ENTRYPOINT ["/init", "--", "/start" ]
CMD ["--integrationnet"]
