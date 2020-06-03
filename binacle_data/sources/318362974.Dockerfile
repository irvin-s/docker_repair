FROM node:10-alpine
LABEL maintainer="Ocean Protocol <devops@oceanprotocol.com>"

RUN apk add --no-cache --update\
      bash\
      g++\
      gcc\
      git\
      krb5-dev\
      krb5-libs\
      krb5\
      make\
      python

COPY . /keeper-contracts
WORKDIR /keeper-contracts

RUN npm install -g npm
RUN npm install

ENTRYPOINT ["/keeper-contracts/scripts/keeper.sh"]
