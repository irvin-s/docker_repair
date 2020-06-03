FROM golang:1.9.2-alpine3.7  
ENV GOPATH /go  
  
RUN set -x \  
&& apk --no-cache add git gcc libc-dev \  
&& mkdir -p /go/src/github.com/cloudflare \  
&& cd /go/src/github.com/cloudflare \  
&& git clone https://github.com/cloudflare/redoctober.git \  
&& mkdir redoctober/bin && cd redoctober/bin \  
&& go build ../. \  
&& echo "Build complete."  
  
FROM alpine:3.7  
COPY \--from=0 /go/src/github.com/cloudflare/redoctober/bin/ /usr/bin  
COPY ./docker-entrypoint.sh /usr/bin/  
  
RUN set -ex \  
&& apk add --update ca-certificates \  
&& update-ca-certificates \  
&& apk add \  
openssl \  
su-exec \  
&& rm -rf /var/cache/apk/* \  
&& addgroup -S redoctober && adduser -S -G redoctober redoctober \  
&& chmod +x /usr/bin/docker-entrypoint.sh  
  
EXPOSE 8080 8081  
ENV RO_CERTS=/var/lib/redoctober/data/server.crt \  
RO_KEYS=/var/lib/redoctober/data/server.pem \  
RO_DATA=/var/lib/redoctober/data \  
RO_CERTPASSWD=password \  
RO_COMMONNAME=localhost \  
KEY_CIPHER=aes128 \  
KEY_NUMBITS=2048 \  
CA_COUNTRY=US \  
CA_STATE=California \  
CA_LOCALITY=Everywhere \  
CA_ORGANIZATION=LOCAL \  
CN=${RO_COMMONNAME}  
  
ENTRYPOINT ["docker-entrypoint.sh"]  
  
CMD ["redoctober", \  
"-addr=:8080", \  
"-vaultpath=/var/lib/redoctober/data/diskrecord.json", \  
"-certs=/var/lib/redoctober/data/server.crt", \  
"-keys=/var/lib/redoctober/data/server.pem"]  

