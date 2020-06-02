FROM debian:latest

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends curl git ca-certificates && \
    # apt-get clean --yes && \
    curl --location https://deb.nodesource.com/setup_0.12 | bash - && \
    apt-get install --yes --no-install-recommends nodejs && \
    npm install --global elm@1.5.2

ENV ELM_HOME /usr/lib/node_modules/elm/share

