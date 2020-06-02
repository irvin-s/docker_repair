FROM buildpack-deps:jessie-curl
COPY config /upspin/config
COPY public.upspinkey /upspin/public.upspinkey
COPY secret.upspinkey /upspin/secret.upspinkey
COPY bin/frontend-gcp /frontend-gcp
COPY src/upspin.io/doc /doc
ENTRYPOINT ["/frontend-gcp", "-letscache=", "-docpath=/doc", "-http=:80", "-https=:443", "-config=/upspin/config"]
EXPOSE 80 443
