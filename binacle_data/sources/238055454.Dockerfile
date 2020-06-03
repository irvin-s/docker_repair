FROM node:7-alpine
# https://github.com/carsenk/explorer
RUN apk --update --no-cache add bash curl jq git && \
    git clone --depth=1 https://github.com/carsenk/explorer.git /opt/carexp && \
    npm install -g bower http-server
WORKDIR /opt/carexp
RUN npm install && bower install --allow-root
ADD start.sh /start.sh
RUN chmod a+x /start.sh
