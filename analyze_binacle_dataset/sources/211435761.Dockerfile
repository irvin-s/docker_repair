FROM alpine

COPY / /data/release/dbuilder

ENTRYPOINT /data/release/dbuilder/init.sh && /bin/bash
