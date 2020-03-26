# VERSION 1.0
# AUTHOR:         Jerome Guibert <jguibert@gmail.com>
# DESCRIPTION:    Fake SQS image based on airdock/rvm
# TO_BUILD:       docker build --rm -t airdock/fake-sqs .
# SOURCE:         https://github.com/airdock-io/docker-fake-sqs

FROM airdock/rvm:latest
MAINTAINER Jerome Guibert <jguibert@gmail.com>
ARG FAKE_SQS_VERSION=0.3.1
USER ruby

RUN mkdir -p /srv/ruby/fake-sqs && cd /srv/ruby/fake-sqs && \
  rvm ruby-2.3 do gem install fake_sqs -v ${FAKE_SQS_VERSION} --no-ri --no-rdoc

USER root

EXPOSE 4568

VOLUME ["/srv/ruby/fake-sqs"]

CMD ["tini", "-g", "--", "gosu", "ruby:ruby", "rvm", "ruby-2.3", "do", "fake_sqs", "--database", "/srv/ruby/fake-sqs/database.yml"]
