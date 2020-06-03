FROM mhart/alpine-iojs:latest

WORKDIR /src
ADD . .

RUN apk-install make gcc g++ python git && \
	  npm install --production && \
	  npm link && \
	  apk del make gcc g++ python git && \
	  rm -rf /tmp/* /root/.npm /root/.node-gyp

ENTRYPOINT ["/usr/bin/udp-balancer"]
