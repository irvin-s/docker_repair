FROM alpine:edge
RUN apk add --no-cache wget git ca-certificates
RUN wget "https://caddyserver.com/download/build?os=linux&arch=amd64&features=git" --quiet -O caddy.tar.gz
RUN tar -zvxf caddy.tar.gz caddy && rm caddy.tar.gz && cp caddy /usr/bin/caddy
COPY caddyfile /etc/caddy/caddyfile
ENTRYPOINT ["caddy","-conf", "/etc/caddy/caddyfile"]
EXPOSE 80 443
