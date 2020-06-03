FROM alpine:3.4

ENV HUGO_VERSION 0.17
ENV HUGO_TARGZ hugo_${HUGO_VERSION}_linux-64bit
ENV HUGO_BINARY hugo_${HUGO_VERSION}_linux_amd64


# Install pygments (for syntax highlighting)
RUN apk update && apk add bash git py-pygments && rm -rf /var/cache/apk/*

# Download and Install hugo
ADD https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/${HUGO_TARGZ}.tar.gz /usr/local/
RUN tar xzf /usr/local/${HUGO_TARGZ}.tar.gz -C /usr/local/bin/ \
	&& rm /usr/local/${HUGO_TARGZ}.tar.gz

RUN mv /usr/local/bin/${HUGO_BINARY}/${HUGO_BINARY} /usr/local/bin/hugo \
	&& rm -rf /usr/local/bin/${HUGO_BINARY}

# Create user
ARG uid=1000
ARG gid=1000
RUN addgroup -g $gid hugo
RUN adduser -D -u $uid -G hugo hugo

RUN mkdir -p /code
WORKDIR /code
USER hugo

EXPOSE 1313
CMD hugo version
