FROM poktnetwork/pocket-node:latest
MAINTAINER Luis C. de Leon <luis@pokt.network>

# Install pre-requisite dependency for aion-web3@1.0.0
# TODO fix this
RUN npm install -g lerna

# Install the AION plugin
RUN pocket-node install pnp-aion

COPY ./entrypoint.sh .

ENTRYPOINT ["./entrypoint.sh"]

CMD ["pocket-node", "start", "-p", "3000", "-h", "-w",  "-o", "/dev/stdout", "-c"]
