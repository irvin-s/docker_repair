FROM node:6 AS builder

COPY . /home/lisk/lisk-faucet/
RUN useradd lisk && \
    chown lisk:lisk -R /home/lisk
USER lisk
RUN cd /home/lisk/lisk-faucet && \
    npm install

FROM node:6-alpine

RUN adduser -D lisk
COPY --chown=lisk:lisk --from=builder /home/lisk/lisk-faucet /home/lisk/lisk-faucet

USER lisk
WORKDIR /home/lisk/lisk-faucet
CMD ["node", "app.js"]
