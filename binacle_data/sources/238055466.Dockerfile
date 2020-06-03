FROM chaincore/developer
RUN apk --update --no-cache add bash curl jq git nodejs
ENV PATH=${PATH}:/usr/bin/chain/
ADD package.json /tmp/package.json
WORKDIR /opt/app
RUN cd /tmp && npm install && mkdir -p /opt/app && cp -a /tmp/node_modules /opt/app/ && rm -rf /tmp/*
ADD index.js /opt/app/
