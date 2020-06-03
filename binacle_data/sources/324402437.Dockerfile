FROM gcr.io/kauri-197812/kauri-contract-abis:latest-dev2

# env settings
ENV GETH_BLOCKCHAIN=rinkeby.infura.io
ENV MONOLITH_EXTERNAL_API=api.dev2.kauri.io
ENV MONOLITH_API=monolith.dev2:8081
ENV KAURI_COMMUNITY_ID="524d2cb07f2d40c992479064209bbb21"
ENV MIXPANEL_TOKEN="627c5ccb5bf7da1d079aef2efaa807c2"
EXPOSE 3000

# setup workspace
RUN mkdir -p /usr/src/app

COPY . /usr/src/app
WORKDIR /usr/src/app/packages/kauri-components
RUN yarn install
WORKDIR /usr/src/app/packages/kauri-web
RUN yarn install
RUN npm run build

CMD "npm" "run" "start"
