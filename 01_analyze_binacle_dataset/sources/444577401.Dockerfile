# Mirror one S3 bucket to another S3 bucket.
# tip @cobbzilla for his work at https://www.gittip.com/cobbzilla/
FROM java:7-jre-alpine

MAINTAINER Panagiotis Moustafellos <pmoust@gmail.com>

RUN apk add --no-cache git bash ca-certificates && \
    git clone https://github.com/cobbzilla/s3s3mirror.git /opt/s3s3mirror && \
    apk del git && \
    rm -rf /opt/s3s3mirror/.git

WORKDIR /opt/s3s3mirror

ENTRYPOINT ["./s3s3mirror.sh"]
