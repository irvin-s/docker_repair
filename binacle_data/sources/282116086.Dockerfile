FROM ethereum/client-go:v1.7.2
RUN set -e -x ;\
    addgroup -S app ;\
    adduser -S -g app app ;\
	mkdir -p /app/rinkeby ;\
    chown -R app:app /app
USER app

ADD production/geth/rinkeby/rinkeby.json /app/rinkeby.json
ADD production/geth/rinkeby/start.sh /app/start.sh
ENTRYPOINT /bin/sh /app/start.sh
