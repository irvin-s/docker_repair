FROM buildpack-deps:jessie-curl
COPY config /upspin/config
COPY public.upspinkey /upspin/public.upspinkey
COPY secret.upspinkey /upspin/secret.upspinkey
COPY serviceaccount.json /upspin/serviceaccount.json
COPY bin/hostserver-gcp /hostserver-gcp
ENTRYPOINT ["/hostserver-gcp", "-letscache=", "-http=:80", "-https=:443", "-config=/upspin/config", "-addr=HOSTNAME:443"]
EXPOSE 80 443
