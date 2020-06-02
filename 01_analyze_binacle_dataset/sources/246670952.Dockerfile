FROM buildpack-deps:jessie-curl
COPY config /upspin/config
COPY public.upspinkey /upspin/public.upspinkey
COPY secret.upspinkey /upspin/secret.upspinkey
COPY mailconfig /upspin/mailconfig
COPY bin/keyserver-gcp /keyserver-gcp
ENTRYPOINT ["/keyserver-gcp", "-letscache=", "-config=/upspin/config", "-kind=server", "-project=PROJECT", "-mail_config=/upspin/mailconfig", "-serverconfig=backend=GCS,gcpBucketName=BUCKET,defaultACL=projectPrivate", "-log=LOGLEVEL", "-addr=HOSTNAME:443"]
EXPOSE 80 443
