FROM ubuntu:16.04

RUN apt-get update && \
    apt-get install -y build-essential ruby-dev zlib1g-dev && \
    apt-get clean

ADD . /opt/s3_multi_upload
WORKDIR /opt/s3_multi_upload

RUN gem build *.gemspec && \
    gem install *.gem && \
    rm -rfv $(pwd)

WORKDIR /root
ENTRYPOINT ["/usr/local/bin/s3_multi_upload"]
CMD ["--help"]