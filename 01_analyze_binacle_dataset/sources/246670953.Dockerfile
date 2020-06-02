FROM karalabe/xgo-latest
ADD makerelease.sh /makerelease.sh
ADD config /config
ADD secrets /secrets
ENTRYPOINT ["/makerelease.sh"]
