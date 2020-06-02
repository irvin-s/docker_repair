FROM centos:centos6
MAINTAINER Jinal Shah <jnshah@gmail.com>
LABEL Description="centos6-minimal with awscli installed" Vendor="sortuniq" Version="0.0.1"

ARG AWS_ACCESS_KEY_ID=set-with-docker-run--env
ARG AWS_SECRET_ACCESS_KEY=set-with-docker-run--env
ARG AWS_REGION=eu-west-1

ENV AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID           \
    AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY   \
    AWS_REGION=$AWS_REGION

COPY .aws/config /root/.aws/config
RUN  sed -i -e "s/AWS_ACCESS_KEY_ID/$AWS_ACCESS_KEY_ID/" \
         -e "s/AWS_SECRET_ACCESS_KEY/$AWS_SECRET_ACCESS_KEY/" \
         -e "s/AWS_REGION/$AWS_REGION/" /root/.aws/config \
  && yum install -y yum-utils unzip telnet lynx \
  && curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "/tmp/awscli-bundle.zip" \
  && unzip /tmp/awscli-bundle.zip -d /tmp/ \
  && /tmp/awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

CMD ["/bin/bash"]
