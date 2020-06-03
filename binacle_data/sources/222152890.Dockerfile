FROM google/cloud-sdk
MAINTAINER jordic <j@tmpo.io>

RUN apt-get update && apt-get install -y curl ca-certificates

COPY bin bin
ADD cron cron
ADD cron.json cron.json

ENTRYPOINT ["/cron", "-cron", "/cron.json"]
