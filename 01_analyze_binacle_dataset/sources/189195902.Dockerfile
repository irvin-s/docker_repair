#BUILD_PUSH=hub,quay

# docker run --net="host" -ti --rm quay.io/bigm/xtetcd-proxy -AllowedPaths=/v2/keys/xtqueue/
FROM scratch
ADD ca-certificates.crt /etc/ssl/certs/
ADD xtetcd-proxy /
EXPOSE 2379
ENTRYPOINT ["/xtetcd-proxy"]
