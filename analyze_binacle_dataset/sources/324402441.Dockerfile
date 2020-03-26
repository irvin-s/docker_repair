FROM gcr.io/kauri-197812/kauri-contract-abis:latest-dev

# env
ENV GETH_BLOCKCHAIN=35.231.60.112:8545
ENV MONOLITH_EXTERNAL_API=api.dev.kauri.io
ENV MONOLITH_API=api.dev.kauri.io
ENV CI=true
ENV DEV_SEED_WORDS="${DEV_SEED_WORDS}"
ENV MIXPANEL_TOKEN="627c5ccb5bf7da1d079aef2efaa807c2"

EXPOSE 3000

# setup workspace
RUN mkdir -p /usr/src/app

COPY . /usr/src/app
WORKDIR /usr/src/app/packages/kauri-web
RUN yarn install

CMD "npm" "run" "test:unit"
