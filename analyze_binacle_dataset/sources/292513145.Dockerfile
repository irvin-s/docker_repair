FROM jbenet/go-ipfs:release
COPY docker/ipfs/start_ipfs_cors /usr/local/bin/start_ipfs_cors
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/start_ipfs_cors"]
CMD ["daemon", "--migrate=true"]
