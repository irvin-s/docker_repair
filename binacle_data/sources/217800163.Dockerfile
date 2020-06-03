# NOTE: do not use nodejs v9 later 
# https://github.com/c9/core/issues/496
FROM node:8

RUN git clone https://github.com/c9/core.git /cloud9 && \
    cd /cloud9 && ./scripts/install-sdk.sh

RUN npm install hexo-cli -g

WORKDIR /workspace
