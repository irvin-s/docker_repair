FROM debian:stretch

RUN set -e;\
  apt-get update;\
  apt-get install curl libpq-dev libtinfo-dev -y;\
  apt-get --purge autoremove;\
  apt-get clean;

ENV \
  LNDR_HOME=/lndr

COPY . "${LNDR_HOME}"

WORKDIR "${LNDR_HOME}"

RUN set -e;\
  [ -f "${LNDR_HOME}/lndr-server" ] && cp "${LNDR_HOME}/lndr-server" /usr/bin/lndr-server;\
  [ -f "/usr/bin/lndr-server" ] \
  || curl \
      -sSL \
      -o /usr/bin/lndr-server \
      $(\
        curl \
          -sSL \
          'https://circleci.com/api/v1.1/project/github/blockmason/lndr/latest/artifacts?branch=master&filter=successful' \
        | awk '/url.+lndr-server/ { print $3; }' \
        | xargs \
      );\
  chmod 0555 /usr/bin/lndr-server;

ENV \
  AWS_ACCESS_KEY_ID="" \
  AWS_SECRET_ACCESS_KEY="" \
  CREDIT_PROTOCOL_ADDRESS="0xd5ec73eac35fc9dd6c3f440bce314779fed09f60" \
  DB_HOST="127.0.0.1" \
  DB_NAME="lndr" \
  DB_PASSWORD="" \
  DB_PORT="5432" \
  DB_USER="" \
  ETHEREUM_PRIVATE_KEY="edc63d0e14b29aaa26c7585e962f93abb59bd7d8b01b585e073dc03d052a000b" \
  ETHEREUM_CLIENT_URL="http://127.0.0.1:8545" \
  ETHEREUM_GAS_PRICE="200000000" \
  ETHEREUM_MAX_GAS="250000" \
  HEARTBEAT_INTERVAL="5" \
  ISSUE_CREDIT_EVENT="0xcbc85a9af1e8adce13cbeff2e71299b0f3243d7ef1eaec93a9a281e939aceb7b" \
  LNDR_BIND_ADDRESS="*4" \
  LNDR_BIND_PORT="7402" \
  LNDR_UCAC_AUD="0xb82acb57fcc7fec3438f02845dfdfad29a4589e4" \
  LNDR_UCAC_CAD="0xd75fcd5ca7b235eaeabc82fda406d7a87101bbc0" \
  LNDR_UCAC_CHF="0x519b1153e2c822e605d36ddb959ba233f658afd1" \
  LNDR_UCAC_CNY="0xe131b33e6a02ae1cd5152c3d2c2812188cdf7f4a" \
  LNDR_UCAC_DKK="0x061a0d4f6e7f71ed18263f188c2fd29945fdce7f" \
  LNDR_UCAC_EUR="0xae0d61120070411bf96b1d0d42fe9f4023e9f8f1" \
  LNDR_UCAC_GBP="0x5c433119ec13fdac42359838f7df93124d054d0c" \
  LNDR_UCAC_HKD="0xb52a2db8ae67a51b1906e4b333930641d62272fd" \
  LNDR_UCAC_IDR="0xfc0f4fe61f23ca895f7e8a51d4e08462f4926687" \
  LNDR_UCAC_ILS="0x77ee746c16a817109567b895ff9b9a75bf354bf4" \
  LNDR_UCAC_INR="0x24c7763f5a10370f5b431926f94daa53398182cc" \
  LNDR_UCAC_JPY="0x9d9462f70067f506ac26bd523222f4f8020924d4" \
  LNDR_UCAC_KRW="0x9945a5b005a898a435adf30fe88f2818ccc0ba5c" \
  LNDR_UCAC_MYR="0x79a5f8d6cc432c1f017648c4fae840dff4cfcaf2" \
  LNDR_UCAC_NOK="0x943b8e14145692f33082ca062ee48be49d48d476" \
  LNDR_UCAC_NZD="0x28a2997d3c21087053b7bb5c244bf06bf84c984e" \
  LNDR_UCAC_PLN="0xc552e50a5829507bd575063c0c77dbee49c9fe58" \
  LNDR_UCAC_RUB="0x14eb816e20af23ef81cc1deeba71d8642edcb621" \
  LNDR_UCAC_SEK="0x55b1d21c802e74b5e2230e9f3af28d22f8128ddd" \
  LNDR_UCAC_SGD="0x3ac772c0f927df3c07cd90c17b536fcab86e0a53" \
  LNDR_UCAC_THB="0x9a76e6a7a56b72d8750f00240363dc06d09c7161" \
  LNDR_UCAC_TRY="0xfe2bbfbe30f835096ccbc9c12a38ac749d8402b2" \
  LNDR_UCAC_USD="0x7899b83071d9704af0b132859a04bb1698a3acaf" \
  LNDR_UCAC_VND="0x815dcbb2008757a469d0daf8c310fae2fc41e96b" \
  NOTIFICATIONS_API_KEY="" \
  NOTIFICATIONS_API_URL="" \
  S3_PHOTO_BUCKET="lndr-avatars" \
  SCAN_START_BLOCK="0" \
  SUMSUB_API_KEY="" \
  SUMSUB_API_URL="" \
  SUMSUB_API_CALLBACK_SECRET=""

ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["start"]
