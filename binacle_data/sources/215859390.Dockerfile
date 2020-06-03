FROM node:11-alpine

RUN apk add --no-cache \
	autoconf \
	automake \
	g++ \
	libpng-dev \
	libtool \
	make \
	nasm

WORKDIR /app

ENTRYPOINT ["yarn"]
CMD ["run", "docker"]
