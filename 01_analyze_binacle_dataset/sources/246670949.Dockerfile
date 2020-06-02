FROM buildpack-deps:jessie-curl
COPY config /upspin/config
COPY public.upspinkey /upspin/public.upspinkey
COPY secret.upspinkey /upspin/secret.upspinkey
COPY bin/dirserver-gcp /dirserver-gcp
ENTRYPOINT ["/dirserver-gcp", "-letscache=", "-config=/upspin/config", "-kind=server", "-storeserveruser=STORESERVERUSER", "-serverconfig=logDir=/dirserver-logs", "-project=PROJECT", "-log=LOGLEVEL"]
EXPOSE 80 443
