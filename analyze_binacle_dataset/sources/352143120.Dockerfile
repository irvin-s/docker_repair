# VERSION 1.0
# AUTHOR:         Jerome Guibert <jguibert@gmail.com>
# DESCRIPTION:    Fake SQS image based on airdock/base
# TO_BUILD:       docker build --rm -t airdock/fake-sqs .
# SOURCE:         https://github.com/airdock-io/docker-fake-sqs

FROM airdock/base:latest
MAINTAINER Jerome Guibert <jguibert@gmail.com>

ARG FAKE_SQS_VERSION=0.1.0

RUN apt-get update -qq && apt-get install -y ruby-full && \
   mkdir -p /opt/fake-sqs && cd /opt/fake-sqs && \
   mkdir -p /srv/fake-sqs && \
   gem install sinatra --no-ri --no-rdoc && gem install fake_sqs:${FAKE_SQS_VERSION} --no-ri --no-rdoc && \
  /root/post-install

EXPOSE 4568

CMD ["fake_sqs",  "--database" , "/srv/fake-sqs/database.yml"]
