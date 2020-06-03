FROM icecrime/vossibility-bulletin
MAINTAINER Arnaud Porterie <icecrime@docker.com>

USER root
RUN apk add jq openssh-client
USER bulletin

RUN git config --global user.name "Arnaud Porterie" && \
    git config --global user.email "icecrime@docker.com" && \
    git config --global credential.helper cache && \
    git config --global push.default matching

ENV ELASTICSEARCH="localhost:9200"
ADD ./weekly/generate /etc/periodic/weekly/generate

ENTRYPOINT ["crond", "-f"]
