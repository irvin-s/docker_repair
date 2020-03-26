FROM m00re/bitcore:3.1.3-b2
# https://github.com/bitpay/insight-ui
# https://github.com/m00re/bitcore-docker
WORKDIR /home/node/bitcore
RUN npm install insight-ui
ADD bitcore-node.json .