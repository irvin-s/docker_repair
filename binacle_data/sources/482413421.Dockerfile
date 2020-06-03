FROM circleci/node:10

USER root

RUN npm install --unsafe-perm -g full-icu
ENV NODE_ICU_DATA="/usr/local/lib/node_modules/full-icu"
