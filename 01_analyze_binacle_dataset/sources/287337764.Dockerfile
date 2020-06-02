FROM poktnetwork/pocket-node:latest
MAINTAINER Luis C. de Leon <luis@pokt.network>

# Install the ETH plugin
RUN pocket-node install pnp-eth

COPY ./entrypoint.sh .

ENTRYPOINT ["./entrypoint.sh"]

CMD ["pocket-node", "start", "-p", "8000", "-h", "-w",  "-o", "/dev/stdout", "-c"]
