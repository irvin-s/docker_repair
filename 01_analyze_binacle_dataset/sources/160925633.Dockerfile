FROM centos:centos6

RUN \
  mkdir -p /opt/rust && \
  yum install -y tar

ADD https://static.rust-lang.org/dist/rust-nightly-x86_64-unknown-linux-gnu.tar.gz /opt/rust/rust-nightly-x86_64-unknown-linux-gnu.tar.gz

RUN \
  cd /opt/rust && \
  tar zxvf rust-nightly-x86_64-unknown-linux-gnu.tar.gz

ENV PATH $PATH:/opt/rust/rust-nightly-x86_64-unknown-linux-gnu/bin
