# Klar v2.4
#
# docker run --rm -e CLAIR_ADDR supinf/klar:2.4 postgres:9.5.1
# docker run --rm -e CLAIR_ADDR -e DOCKER_USER -e DOCKER_PASSWORD supinf/klar:2.4 "${REGISTRY}/my-image:1.0"
# docker run --rm -e CLAIR_ADDR -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY supinf/klar:2.4 "${ECR}/my-image:1.0"

FROM alpine:3.8

RUN apk --no-cache add ca-certificates
RUN apk --no-cache add curl && curl --location --silent -o /usr/bin/ecr-creds \
    https://github.com/pottava/ecr-creds/releases/download/v1.0.0/linux_amd64 \
    && apk del --purge -r curl
RUN chmod +x /usr/bin/ecr-creds

ENV CLAIR_ADDR=http://localhost:6060 \
    CLAIR_OUTPUT=Medium \
    CLAIR_THRESHOLD=10 \
    CLAIR_TIMEOUT=1 \
    DOCKER_USER= \
    DOCKER_PASSWORD= \
    DOCKER_TOKEN= \
    DOCKER_INSECURE=false \
    REGISTRY_INSECURE=false \
    FORMAT_OUTPUT=json \
    IGNORE_UNFIXED=false \
    AWS_ACCESS_KEY_ID= \
    AWS_SECRET_ACCESS_KEY= \
    AWS_DEFAULT_REGION=ap-northeast-1

ADD https://github.com/optiopay/klar/releases/download/v2.4.0/klar-2.4.0-linux-amd64 /usr/bin/klar
RUN chmod +x /usr/bin/klar

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
