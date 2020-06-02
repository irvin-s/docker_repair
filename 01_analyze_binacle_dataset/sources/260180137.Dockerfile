FROM nlepage/distroless-http

COPY Caddyfile /Caddyfile

COPY build/ /www

CMD ["-conf", "/Caddyfile"]
