FROM saksmlz/openresty-docker:1.11.2.1-2-slim

ENV NR_SDK_VERSION=0.16.2.0-beta

RUN set -ex \
      && apt-get update \
      && apt-get install --yes --no-install-recommends perl curl libcurl3 \
      && curl -L https://download.newrelic.com/agent_sdk/nr_agent_sdk-v${NR_SDK_VERSION}.x86_64.tar.gz | tar -C /opt -xzf - \
      && cp /opt/nr_agent_sdk-v${NR_SDK_VERSION}.x86_64/lib/*.so /lib/ \
      && rm -rf /opt/nr_agent_sdk-v${NR_SDK_VERSION}.x86_64/ \
      && apt-get purge --yes --auto-remove curl \
      && rm -rf /var/lib/apt/lists/*

RUN set -ex \
      && apt-get update \
      && apt-get install --yes --no-install-recommends git curl unzip \
      && luarocks install resty-newrelic 0.01-6 \
      && luarocks install lua-resty-repl \
      && apt-get purge --yes --auto-remove git curl unzip \
      && rm -rf /var/lib/apt/lists/*
