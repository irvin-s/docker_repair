FROM node:alpine

# install and build xmrig
RUN apk upgrade --no-cache \
	&& apk add --no-cache --virtual build-dependencies git build-base libuv-dev cmake \
	&& apk add --no-cache tini libuv \
	&& git clone --depth=1 https://github.com/xmrig/xmrig /xmrig-src \
	&& sed -i 's/DonateLevel = ./DonateLevel = 0/g' /xmrig-src/src/donate.h \
	&& mkdir /xmrig \
	&& cd /xmrig \
	&& cmake /xmrig-src -DWITH_HTTPD=OFF \
	&& make \
	&& apk del build-dependencies \
	&& rm -rf /xmrig-src

# Add Node.js proxy server to container
ADD xm /xm
RUN cd /xm \
	&& npm -g i forever \
	&& npm i

ADD run.sh /xmrig
ENTRYPOINT ["/sbin/tini", "-g", "--", "/bin/ash", "/xmrig/run.sh"]
