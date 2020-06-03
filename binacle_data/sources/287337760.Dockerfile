FROM poktnetwork/pocket-node:latest
MAINTAINER Luis C. de Leon <luis@pokt.network>

# Install pre-requisite dependency for aion-web3@1.0.0
# TODO fix this

RUN npm install -g lerna

COPY . .

# Install plugins
RUN bash install.sh 

ENTRYPOINT ["./entrypoint.sh"]

CMD ["pocket-node", "start", "-h", "-w", "-p", "8000", "-o", "/dev/stdout", "-c"]
