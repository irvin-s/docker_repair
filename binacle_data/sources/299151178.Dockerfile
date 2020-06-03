ARG PARITY_VERSION=${PARITY_VERSION}
FROM parity/parity:${PARITY_VERSION}
ARG NETWORK_NAME=${NETWORK_NAME}
USER root
COPY --chown=parity ./parity/config /parity/config
COPY --chown=parity ./parity/keys /home/parity/.local/share/io.parity.ethereum/keys/${NETWORK_NAME}.
RUN chown -R parity: /home/parity/.local/share/io.parity.ethereum
USER parity
