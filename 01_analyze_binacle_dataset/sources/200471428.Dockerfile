FROM alpine:latest
RUN apk add --no-cache curl ca-certificates && \
  curl -sL $(curl -s https://api.github.com/repos/coreos/etcd/releases/latest \
    | grep -E '"browser_download_url.*etcd-.*-linux-amd64.tar.gz"' | cut -d\" -f4) | tar -C /tmp -xz \
  && mv /tmp/etcd-*-linux-amd64/etcd* /usr/local/bin/ \
  && chmod 755 /usr/local/bin/etcd*
VOLUME /data
EXPOSE 2379 2380 4001 7001
ADD run.sh /bin/run.sh
ENTRYPOINT  ["/bin/run.sh"]
