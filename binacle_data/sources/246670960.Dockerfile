FROM buildpack-deps:jessie-curl
COPY config /upspin/config
COPY public.upspinkey /upspin/public.upspinkey
COPY secret.upspinkey /upspin/secret.upspinkey
COPY bin/storeserver-gcp /storeserver-gcp
ENV TMPDIR /
ENTRYPOINT ["/storeserver-gcp", "-letscache=", "-config=/upspin/config", "-kind=server", "-serverconfig=backend=GCS,gcpBucketName=BUCKET,defaultACL=publicRead", "-project=PROJECT", "-log=LOGLEVEL"]
EXPOSE 80 443
